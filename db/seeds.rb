# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

   
    ledger = Ledger.create({ name: "San Francisco General Ledger", balance: 100.00 })
    ledger.transactions.create([
                                { amount: 3.95, date:  31.days.ago, transaction_type: "expense", description: "books" },
                                { amount: 6.05, date:  31.days.ago, transaction_type: "expense", description: "notebooks" },
                                { amount: 20.00, date: 31.days.ago,  transaction_type: "revenue", description: "Bill" },
                                { amount: 100.00, date: 60.days.ago,  transaction_type: "revenue", description: "Bill" },
                                { amount: 15.95, date: 15.days.ago, transaction_type: "expense", description: "Pens" },
                                { amount: 4.05,  date: 10.days.ago, transaction_type: "expense", description: "Pencil" },
                                { amount: 40.00, date: 2.days.ago,  transaction_type: "revenue", description: "Bill" }
                              ])

     
