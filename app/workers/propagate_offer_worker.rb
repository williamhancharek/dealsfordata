class PropagateOfferWorker
  include Sidekiq::Worker

  #TODO very probably the propagate function is broken in some way.  I think that my referrer array is fucked

  def perform(offer_id)
    #TODO I should refactor this later so it's more scalable - make it so this
    #method creates a bunch of smaller methods that create the offers
    offer = Offer.find(offer_id)
    box = Box.find(offer.box.id) #this is the box that is sending its subscribers the message

    box.subscribers.each do |sub|
      new_offer = sub.offers.find_or_create_by(original_offer_id: offer_id)
      #if (new_offer.referrer.nil? || !(new_offer.referrer.include?(box.id)))
      #TODO this line was to ENSURE WE DON'T HAVE CIRCULAR REFERRALS but it's broken - bad logic
      ActiveRecord::Base.transaction do
        new_offer.referrer ||= []
        new_offer.referrer.push(box.id) #this will always just have one number for now
        new_offer.description ||= offer.description
        new_offer.title ||= offer.title
        new_offer.tags ||= offer.tags
        new_offer.options ||=offer.options
        new_offer.public_options ||= offer.public_options
        new_offer.box_id ||=sub.id
        new_offer.campaign_id ||= offer.campaign.id
        new_offer.commentary ||= offer.received_commentary
        new_offer.original_offer_id ||= offer.id
        new_offer.approved ||= offer.approved
        new_offer.link ||= offer.link
        new_offer.active ||= "true"
        new_offer.save!
        if sub.allow_email == "true"
          OfferMailer.with(offer_id: new_offer.id).referral_email.deliver_later
        end
      end
    end
  end
end
