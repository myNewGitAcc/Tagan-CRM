class Commission < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :company

  before_create :search_exist_commission

  private

  def search_exist_commission
    commission = Commission.where(company_id: self.company_id, deleted_at: nil)
    commission.first.destroy if commission.exists?
  end

end