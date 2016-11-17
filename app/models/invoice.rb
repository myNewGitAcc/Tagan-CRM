class Invoice < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :company
  belongs_to :internal_account

  before_create :ensure_company
  after_commit :ensure_debit_credit, on: :create

  private

  def ensure_company
    company = Company.find_by_name(self.team)
    self.company_id = company.id if company.present?
  end

  def ensure_debit_credit
    amount = self.amount
    if self.company.present?
      commission =  self.company.commissions.last.percent
      result_commision = (amount.to_f * commission)/100
      result_amount = amount - result_commision

      save_debit(result_commision)
      save_credit(result_amount)
    end
  end

  def save_debit commission
    Debit.create(transaction_params('Upwork commission', commission))
  end

  def save_credit amount
    Credit.create(transaction_params("#{self.type_of_calculation}, #{self.description}", amount))
  end

  private

  def transaction_params name, total
    {company_id: self.company.id, name: name, amount: total,created_at: self.date,internal_account_id: self.internal_account_id,info: { invoice_id: self.id } }
  end
end