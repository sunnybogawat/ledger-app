class Transaction < ApplicationRecord
  belongs_to :ledger
  TRANSACTION_TYPES = ["expense","revenue"]
 
  validates :ledger, presence: true
  validates :amount, presence: true, numericality: true
  validates :transaction_type, presence: true, inclusion: { in: TRANSACTION_TYPES}

  scope :expenses,   -> (ledger){ where(ledger_id: ledger.id, transaction_type: "expense") }
  scope :revenue, ->(ledger){ where(ledger_id: ledger.id, transaction_type: "revenue") } 
  scope :by_year, lambda { |year| where('extract(year from date) = ?', year) }
  scope :by_month, lambda { |month| where('extract(month from date) = ?', month) } 
end
