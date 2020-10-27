require 'rails_helper'

RSpec.describe 'Transactions API' do
  # Initialize the test data
  let!(:ledger) { create(:ledger) }
  let!(:transactions) { create_list(:transaction, 20, ledger_id: ledger.id) }
  let(:ledger_id) { ledger.id }
  let(:id) { transactions.first.id }
  let(:year) { Time.now.year}
  let(:month) { Time.now.month }

  # Test suite for GET /api/v1/ledgers/:ledger_id/transactions
  describe 'GET /api/v1/ledgers/:ledger_id/transactions' do
    before { get "/api/v1/ledgers/#{ledger_id}/transactions" }

    context 'when ledger exists' do
      it 'returns status code 200' do
	    expect(response).to have_http_status(200)
      end

      it 'returns all ledger transactions' do
	    result = JSON(response.body)
        expect(result.size).to eq(20)
      end
    end

    context 'when ledger does not exist' do
      let(:ledger_id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match("{\"message\":\"Couldn't find Ledger with 'id'=0\"}")
      end
    end
  end

  # Test suite for GET /api/v1/ledgers/:ledger_id/transactions/:id
  describe 'GET /api/v1/ledgers/:ledger_id/transactions/:id' do
    before { get "/api/v1/ledgers/#{ledger_id}/transactions/#{id}" }

    context 'when ledger transaction exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the transaction' do
      result = JSON(response.body)
        expect(result['id']).to eq(id)
      end
    end

    context 'when ledger transaction does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Transaction/)
      end
    end
  end

  # Test suite for POST /api/v1/ledgers/:ledger_id/transactions
  describe 'POST /api/v1/ledgers/:ledger_id/transactions' do
    let(:valid_attributes) { {  amount: 3.95, date:  31.days.ago, transaction_type: "expense", description: "books" } }

    context 'when request attributes are valid' do
      before { post "/api/v1/ledgers/#{ledger_id}/transactions", params: valid_attributes }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when an invalid request' do
      before { post "/api/v1/ledgers/#{ledger_id}/transactions", params: {} }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Validation failed: Amount can't be blank/)
      end
    end
  end


  # Test suite for current balance  /api/v1/ledgers/:ledger_id/current_balance
  describe 'api/v1/ledgers/:ledger_id/current_balance' do
    before { get "/api/v1/ledgers/#{ledger_id}/current_balance" }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
  
   # Test suite for ledger total  /api/v1/ledgers/:ledger_id/ledger_totals/:year/:month
  describe '/api/v1/ledgers/:ledger_id/ledger_totals/:year/:month' do
    before { get "/api/v1/ledgers/#{ledger_id}/ledger_totals/#{year}/#{month}" }

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
 
  # Test suite for DELETE /api/v1/ledgers/:id
  describe 'DELETE /api/v1/ledgers/:id' do
    before { delete "/api/v1/ledgers/#{ledger_id}/transactions/#{id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
