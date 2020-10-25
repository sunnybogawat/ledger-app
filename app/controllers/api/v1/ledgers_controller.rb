class Api::V1::LedgersController < ApplicationController
  before_action :set_ledger, only: [:show, :destroy, :totals,:current_balance]
  
  def index
   @ledgers = Ledger.all
   json_response(@ledgers)
  end

  def show
    json_response(@ledger)
  end

  def create
   @ledger = Ledger.new(ledger_params)
   if @ledger.save
    json_response(@ledger,:created)
   else
    render error: {error: "Unable to create ledger"}, status: 400
   end
  end
  
  def destroy
   @ledger.destroy
   head :no_content
  end
  
  def current_balance
    balance  = @ledger.balance + Transaction.revenue(@ledger).sum(:amount) - Transaction.expenses(@ledger).sum(:amount) 
    render json: {
    balance: balance
   }
  end
  
  def totals
   expenses = Transaction.expenses(@ledger).by_year(params[:year]).by_month(params[:month]).sum(:amount)
   revenue = Transaction.revenue(@ledger).by_year(params[:year]).by_month(params[:month]).sum(:amount)
   render json: {
    expenses: expenses, revenue: revenue
   }
  end

  private
  
  def set_ledger
    @ledger = Ledger.find(params[:id] || params[:ledger_id])
  end
  
  def ledger_params
   params.require(:ledger).permit(:name,:balance)
  end 
end
