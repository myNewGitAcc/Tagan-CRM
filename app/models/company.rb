class Company < ActiveRecord::Base
  acts_as_paranoid

  has_many :rates
  has_many :commissions
  has_many :transactions
  has_many :invoices

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