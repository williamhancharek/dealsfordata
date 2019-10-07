class AddAmountCategoryCategoryIdDateIsoCurrencyCodesNamePendingTransactionIdTransactionPlaceToTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :transactions, :amount, :float
    add_column :transactions, :category, :string
    add_column :transactions, :category_id, :integer
    add_column :transactions, :date, :date
    add_column :transactions, :iso_currency_code, :string
    add_column :transactions, :location, :string
    add_column :transactions, :name, :string
    add_column :transactions, :payment_meta, :hstore
    add_column :transactions, :payment_location, :hstore
    add_column :transactions, :pending, :bool
    add_column :transactions, :transaction_id, :string
    add_column :transactions, :transaction_place, :string
  end
end
