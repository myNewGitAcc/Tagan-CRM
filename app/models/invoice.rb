class Invoice < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :company

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
    Debit.create(company_id: self.company.id, name: 'Upwork commission', amount: commission, info: { invoice_id: self.id } )
  end

  def save_credit amount
    Credit.create(company_id: self.company.id, name: "#{self.type_of_calculation}, #{self.description}", amount: amount, info: { invoice_id: self.id } )
  end
end