class InternalAccount < ActiveRecord::Base
  acts_as_paranoid

  has_many :invoices, dependent: :destroy
  has_many :transactions, dependent: :destroy

  enum account_type: [ :card, :bank]
end
