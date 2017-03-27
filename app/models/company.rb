class Company < ActiveRecord::Base
  acts_as_paranoid

  has_many :rates, dependent: :destroy
  has_many :commissions, dependent: :destroy
  has_many :transactions, dependent: :destroy
  has_many :invoices, dependent: :destroy

  after_commit :ensure_a_rates_with_commisions, on: :create

  private

  def ensure_a_rates_with_commisions
    ensure_a_rates
    ensure_comissions
  end

  def ensure_a_rates
    self.rates.create
  end

  def ensure_comissions
    self.commissions.create
  end

end
