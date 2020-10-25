class Api::V1::LedgersController < ApplicationController
  before_action :set_ledger, only: [:show, :destroy]
  
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

  private
  
  def set_ledger
    @ledger = Ledger.find(params[:id])
  end
  
  def ledger_params
   params.require(:ledger).permit(:name,:balance)
  end 
end
