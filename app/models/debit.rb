class Debit < Transaction
  scope :write_off, -> { where.not(name: 'Upwork commission') }
end