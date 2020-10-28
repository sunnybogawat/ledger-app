# README

This is a ledger API app where users can create ledgers and then add expense and revenue transactions to
those ledgers. 

It supports following rest end points
# Create ledger
   POST   /api/v1/ledgers
   
   input: { name: “San Francisco General Ledger”, starting_balance: 100.00 }
   
# Create transaction
    POST   /api/v1/ledgers/:ledger_id/transactions
    
    input: { ledger_id: 1, amount: 13.95, date: "2020-01-15", type: "expenses", description: "Pens" }
    
    input: { ledger_id: 1, amount: 8.79, date: "2020-01-22", type: "expenses", description: "Pencils" }
    
    input: { ledger_id: 1, amount: 38.01, date: "2020-01-26", type: "revenues", description: "Parking meter fees" }
    
    input: { ledger_id: 1, amount: 24.20, date: "2020-02-15", type: "expenses", description: "Staplers" }
    
    
# List transactions

    GET    /api/v1/ledgers/:ledger_id/transactions
    
    input: { ledger_id: 1 }
    
    
# Get ledger totals

    GET    /api/v1/ledgers/:ledger_id/ledger_totals/:year/:month
    
    input: { ledger_id: 1, year: “2020”, month: “01” }
    
    input: { ledger_id: 1, year: “2020”, month: “02” }
    
# Get current balance

   GET    /api/v1/ledgers/:ledger_id/current_balance
   
   input: { ledger_id: 1 }
   


 Following are the few important points to be considered for scaling rails app
 
 # Make Code as Simple as Possible
 # Use of Right Gem
 # Choosing a app server 
   Choose a multi-process web server with slow client protection and smart routing/pooling. 
   Examples:- Unicorn with an nginx frontend, or Phusion Passenger 5.
 # Implementation of Caching for fast response time
   gateway or reverse proxy caches to cache HTTP responses
   Memcache to cache results that you’d pull from your database
 # Segregation of data, sharding and replication of DB 
   segregate the jobs and schedule it as per the resource consumption of your background.
 





