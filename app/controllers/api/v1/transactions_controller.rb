class Api::V1::TransactionsController < ApplicationController
 before_action :fetch_ledger
 before_action :set_ledger_transaction, only: [:show, :destroy]

  def index
   json_response(@ledger.transactions)
  end
  
  def show
   json_response(@transaction)
  end

  def create
    @ledger.transactions.create!(transaction_params)
    json_response(@ledger, :created)
  end

  def destroy
    @transaction.destroy
    head :no_content
  end  
 
  private 

  def transaction_params
    params.permit(:amount, :date, :transaction_type, :description)
  end
  
  def fetch_ledger
   @ledger = Ledger.find(params[:ledger_id])
  end

  def set_ledger_transaction
    @transaction = @ledger.transactions.find_by!(id: params[:id]) if @ledger
  end
end
