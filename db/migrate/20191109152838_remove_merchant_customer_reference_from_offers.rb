class RemoveMerchantCustomerReferenceFromOffers < ActiveRecord::Migration[6.0]
  def change
    remove_reference :offers, :merchant
    remove_reference :offers, :customer 
  end
end
