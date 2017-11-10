class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :token_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable

  before_save   :ensure_authentication_token
  after_create  :request_mailbox_create
  after_update  :request_mailbox_update, if: :email_changed?
  after_destroy :request_mailbox_destroy
  acts_as_api

  enum role: [:admin, :management, :developers, :trainees]
  enum status: [:offline, :online, :away]

  has_many :working_times
  has_many :exercises
  has_many :user_scores
  has_many :mail_server_emails

  api_accessible :basic do |t|
    t.add :id
    t.add :email
    t.add :role
    t.add :full_name
    t.add :status
    t.add lambda{|user| user.get_working_times}, as: :hours
    t.add :created_at
  end

  api_accessible :default_token, extend: :basic do |t|
    t.add :authentication_token, as: :access_token
  end

  api_accessible :my_profile_mode, extend: :default_token do |t|
    t.add :id
    t.add :sign_in_count
    t.add :current_sign_in_at
    t.add :current_sign_in_ip
    t.add :confirmed_at
  end

  class << self
    def authenticate(email_or_username, password)
      user = where(["lower(email) = :value", { :value => email_or_username.downcase }]).first
      return nil unless user
      unless user.valid_password?(password)
        sign_in_attributes = {
            failed_attempts: user.failed_attempts.to_i + 1
        }
        user.update_columns(sign_in_attributes)
        user.lock_access! if user.failed_attempts >= Devise.maximum_attempts
        return nil
      end
      user.unlock_access! if user.access_locked? && user.locked_at < Devise.unlock_in.ago
      user
    end

    def find_for_database_authentication(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_h).where(["lower(email) = :value", { :value => login.downcase }]).first
      else
        where(conditions).first
      end
    end
  end

  def validate_request!(request, params)
    if access_locked?
      errors.add(:account,'is locked please contact us')
    # elsif !confirmed?
    #   errors.add(:email,'is not confirmed yet')
    elsif timedout?(current_sign_in_at)
      errors.add(:session, 'expired. Please make re-login.')
    else
      sign_in_attributes = {
          current_sign_in_ip: request.env['REMOTE_ADDR'],
          current_sign_in_at: DateTime.now,
          last_sign_in_at: DateTime.now,
          last_sign_in_ip: request.env['REMOTE_ADDR'],
          sign_in_count:   (sign_in_count.to_i + 1)
      }

      update_columns(sign_in_attributes)
    end
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def get_working_times
    current_today = Date.today
    working_time = self.working_times.find_by(created_at: current_today.beginning_of_day..current_today.end_of_day)
    if working_time.present?
      return working_time.labor_hours/3600000
    else
      return 0
    end
  end

  def ensure_authentication_token
    self.authentication_token ||= generate_authentication_token
  end

  def request_mailbox_create
    net_ssh_tunnel('create')
  end

  def request_mailbox_update
    net_ssh_tunnel('update')
  end

  def request_mailbox_destroy
    net_ssh_tunnel('destroy')
  end

  def debit_score! value, note
    user_scores.create(type: 0, value: value, note: note)
    inform_by_slack value, note
    inform_by_email value, note

    # User.where(role: 1).each do |user|
    #   user.inform_by_slack value, note
    # end
  end

  private

  def inform_by_slack value, note
    SlackPublish.new(
        message: "Hey бля @#{self.slack_name} ! Ты получил #{value} дебетового балла \n" + note,
        note_text: "*** Каждый твой дебетовый балл это не только минус в твою ЗП, \n но и минус из положительного отношения к тебе. ***",
        note_color: '#ff0000',
        channel_name: 'general'
    ).publish if Rails.env == 'production'
  end

  def inform_by_email value, note
    GaysMailer.auto_debit_score(email, "Ты получил #{value} дебетового балла", note).deliver_now
  end

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end

  def net_ssh_tunnel operator
    Net::SSH.start(ENV['EXTERNAL_IP'], ENV['MAIL_SERVER_USER'],
                   :keys_only => true,
                   :key_data => ENV['MAIL_SERVER_KEY_PEM']
    ) do |session|
        session.exec!("sudo sh address_sync #{self.email} #{operator} '#{full_name}' #{self.password}")
    end
  end

end
