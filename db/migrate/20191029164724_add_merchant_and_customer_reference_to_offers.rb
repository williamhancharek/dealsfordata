class AddMerchantAndCustomerReferenceToOffers < ActiveRecord::Migration[6.0]
  def change
    add_reference :offers, :customer, null: false
    add_reference :offers, :merchant, null: false
  end
end
