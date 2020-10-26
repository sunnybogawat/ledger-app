# spec/requests/todos_spec.rb
require 'rails_helper'

RSpec.describe 'Ledger API', type: :request do
  # initialize test data
  let!(:ledgers) { create_list(:ledger, 10) }
  let(:ledger_id) { ledgers.first.id }

  # Test suite for GET /todos
  describe 'GET /api/v1/ledgers' do
    # make HTTP get request before each example
    before { get '/api/v1/ledgers' }

    it 'returns ledgers' do
      # Note `json` is a custom helper to parse JSON responses
      result = JSON(response.body)
      expect(result).not_to be_empty
      expect(result.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  # Test suite for GET /ledgers/:id
  describe 'GET /api/v1/ledgers/:id' do
    before { get "/api/v1/ledgers/#{ledger_id}" }

    context 'when the record exists' do
      it 'returns the ledger' do
        result = JSON(response.body)
        expect(result).not_to be_empty
        expect(result['id']).to eq(ledger_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:ledger_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Ledger/)
      end
    end
  end

  # Test suite for POST /todos
  describe 'POST /api/v1/ledgers' do
    # valid payload
    
    let(:valid_attributes) do
    { 
      ledger: { 
               name: 'Learn Elm', balance: 100 
      }
    } 
    end

    context 'when the request is valid' do
      before { post '/api/v1/ledgers', params: valid_attributes }

      it 'creates a ledger' do
        result = JSON(response.body)
        expect(result['name']).to eq('Learn Elm')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/api/v1/ledgers', params: { ledger: {name: 'Foobar' } }}

      it 'returns status code 422' do
        expect(response).to have_http_status(400)
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Balance can't be blank/)
      end
    end
  end


  # Test suite for DELETE /todos/:id
  describe 'DELETE /api/v1/ledgers/:id' do
    before { delete "/api/v1/ledgers/#{ledger_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
