class PropagateOfferJob < ApplicationJob
  queue_as :default

  def perform(offer_id:, box_id:)
    #to make it idempotent, we need to first check to see if it already exists in the db
    

  end

end
