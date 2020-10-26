require 'rails_helper'

RSpec.describe Transaction, type: :model do
 it { should belong_to(:ledger) }
 it { should validate_presence_of(:ledger) }
 it { should validate_presence_of(:amount) }
 it { should validate_numericality_of(:amount)}
 it { should validate_presence_of(:transaction_type) }
 it { should validate_inclusion_of(:transaction_type).in_array(%w[expense revenue]) }
end
