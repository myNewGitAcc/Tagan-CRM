class InternalAccount < ActiveRecord::Base
  acts_as_paranoid

  has_many :invoices
  has_many :transactions

  enum account_type: [ :card, :bank]
end