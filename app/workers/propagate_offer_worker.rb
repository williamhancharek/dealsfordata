class PropagateOfferWorker
  include Sidekiq::Worker

  def perform(offer_id, box_id)
    #TODO I should refactor this later so it's more scalable - make it so this
    #method creates a bunch of smaller methods that create the offers
    puts "hello"

    box = Box.find(box_id) #this is the box that is sending its subscribers the message
    offer = Offer.find(offer_id)

    box.subscribers.each do |sub|
      new_offer = sub.offers.find_or_create_by(original_offer_id: offer_id)
      if (new_offer.referrer.nil? || new_offer.referrer.include?(box.id))
        new_offer.referrer ||= []
        new_offer.referrer.push(box.id)
        new_offer.description ||= offer.description
        new_offer.title ||= offer.title
        new_offer.tags ||= offer.tags
        new_offer.options ||=offer.options
        new_offer.public_options ||= offer.public_options
        new_offer.box_id ||=sub.id
        new_offer.campaign_id ||= offer.campaign.id
        new_offer.received_commentary ||= offer.commentary
        new_offer.original_offer_id ||= offer.id
        new_offer.save
      end
    end
  end

end
