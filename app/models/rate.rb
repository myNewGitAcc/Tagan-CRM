class Rate < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :company

  before_create :search_exist_rate

  private

  def search_exist_rate
    rate = Rate.where(company_id: self.company_id, deleted_at: nil)
    rate.first.destroy if rate.exists?
  end

end