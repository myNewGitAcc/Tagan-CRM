class Transaction < ActiveRecord::Base
  acts_as_paranoid

  belongs_to :company
  belongs_to :internal_account

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
end