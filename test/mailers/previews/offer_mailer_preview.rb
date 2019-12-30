# Preview all emails at http://localhost:3000/rails/mailers/offer_mailer
class OfferMailerPreview < ActionMailer::Preview

  def offer_email
    OfferMailer.with(offer_id: Offer.last.id).offer_email
  end

  def referral_email
    OfferMailer.with(offer_id: Offer.last.id).referral_email
  end
end
