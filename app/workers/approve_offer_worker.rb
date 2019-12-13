class ApproveOfferWorker
  include Sidekiq::Worker

  def perform(offer_id)
    offer = Offer.find(offer_id)
    #TODO I should refactor this later so it's more scalable - make it so this
    #method creates a bunch of smaller methods that create the offers

    if offer.approved == true && offer.status == true && offer.box.allow_email == true && (offer.email_sent == nil || offer.email_sent == false)

      ActiveRecord::Base.transaction do
        offer.email_sent = true
        OfferMailer.with(offer_id: @offer.id).offer_email.deliver_later
      end
        #TODO to make this idempotent I need a switch to flip to know that the email was sent
    end
  end
end
