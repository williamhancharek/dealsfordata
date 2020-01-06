class PropagateOfferWorker
  include Sidekiq::Worker

  #TODO very probably the propagate function is broken in some way.  I think that my referrer array is fucked

  def perform(offer_id)
    #TODO I should refactor this later so it's more scalable - make it so this
    #method creates a bunch of smaller methods that create the offers
    offer = Offer.find(offer_id)
    box = Box.find(offer.box.id) #this is the box that is sending its subscribers the message

    box.subscribers.each do |sub|

      if offer.original_offer_id == offer.id
        #if the referrer is the original box, then this is an originating offer, therefore create referring offers
        new_offer = sub.offers.create(original_offer_id: offer_id)
        #TODO I should put a database restriction that there can only be one original_offer_id per box
      else
        #if the offer has a referrer, then this is not an originating offer.  we have to check to see if the user already received an offer like this.  They MAY or MAY NOT have gotten this offer.  If they did get this offer, then we want to load the offer that already exists
        new_offer = sub.offers.find_or_create_by(original_offer_id: offer.original_offer_id)
      end
      #The purpose of the above if statement is to set the original_offer_id correctly.

      #at this point, the offer definitely has an original_offer_id, and it was either already referred, or it was not yet referred to the box.  In the case where it was already referred, all we want to do is add to the referrer array.

    #the referrer array will be empty when it is an original offer

      ActiveRecord::Base.transaction do

        #if the new_offer.original_offer_id is already contained in the list of offers for the box, then just add the referrer.  If it is not, then proceed to create the offer
        if sub.offers.includes(original_offer_id: new_offer.original_offer_id)
          new_offer.referrer ||= []
          new_offer.referrer.push(box.id)
          new_offer.save!
          #the original_offer_id is already among the offers sent to the box, so the offer has already been seen and no email has to be sent or anything.
        else
          #the original_offer_id was not found, so the box does not have the offer.  Create the offer and send it
          new_offer.referrer ||= []
          new_offer.referrer.push(box.id)
          new_offer.description ||= offer.description
          new_offer.title ||= offer.title
          new_offer.tags ||= offer.tags
          new_offer.options ||=offer.options
          new_offer.public_options ||= offer.public_options
          new_offer.box_id ||=sub.id
          new_offer.campaign_id ||= offer.campaign.id
          new_offer.commentary ||= offer.received_commentary
          new_offer.approved ||= offer.approved
          new_offer.link ||= offer.link
          new_offer.active ||= true
          new_offer.save!
          if (sub.allow_email == true || sub.allow_email == "true")
            OfferMailer.with(offer_id: new_offer.id).referral_email.deliver_later
          end
        end
      end
    end
  end
end
