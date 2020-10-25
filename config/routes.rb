Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   namespace :api do
     namespace :v1 do
        resources :ledgers, only: [:index,:show,:new,:create,:destroy]  do
          get '/ledger_totals/:year/:month', to: 'ledgers#totals'
          get '/current_balance', to: 'ledgers#current_balance'
	  resources :transactions, only: [:index,:show,:new,:create,:destroy] do
	  end
        end
     end
   end
end
