class Ledger < ApplicationRecord
 has_many :transactions, dependent: :destroy
 
 validates :name, presence: true
 validates :balance, presence: true
end
