class Transaction < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :company
  belongs_to :internal_account

  scope :active_account, -> {
    joins(:internal_account).where(internal_accounts: { active: true } )
  }

  ransacker :employee_name do |parent|
    Arel::Nodes::InfixOperation.new(
        '->>', parent.table[:info], Arel::Nodes.build_quoted('employee_name'))
  end

  ransacker :invoice_info do |parent|
    Arel::Nodes::InfixOperation.new(
        '->>', parent.table[:info], Arel::Nodes.build_quoted('invoice_id'))
  end

  def info_raw
    self.info unless self.info.nil?
  end

  def info_raw=(values)
    write_attribute(:info, JSON.parse(values.gsub('=>',':')))
  end

  def self.transaction_by_type type, period
    self
      .where(type: type)
      .select("date_trunc('#{period}', transactions.created_at) as period", "SUM(amount) as total", :type)
      .group("date_trunc('#{period}', transactions.created_at), type")
      .order('period')
  end
end