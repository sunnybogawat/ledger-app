class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.references :ledger, foreign_key: true
      t.decimal :amount
      t.date :date
      t.string :transaction_type
      t.string :description

      t.timestamps
    end
  end
end
