class ApproveOfferWorker
  include Sidekiq::Worker

  def perform(offer_id)
    offer = Offer.find(offer_id)
    if (offer.approved == true || offer.approved == "true") &&
      (offer.active == true || offer.approved == "true") &&
      (offer.box.allow_email == true || offer.box.allow_email == "true") &&
      (offer.email_sent == nil || (offer.email_sent == false || offer.email_sent == "false"))
        ActiveRecord::Base.transaction do
          OfferMailer.with(offer_id: offer.id).offer_email.deliver_later
          offer.email_sent = true
          offer.save
      end
    end
  end
end
