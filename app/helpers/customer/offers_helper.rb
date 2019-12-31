module Customer::OffersHelper

  def sendOffer(offer:, f:) #TODO no longer needed since all offers that are public autoforward answer
    if offer.box.public?
      render partial: "public_offer_selection", locals: {f: f, offer: offer}
    end
  end

  def referralInfo(offer:)
    if offer.original_offer_id.present?
      box = Box.find(offer.referrer.last)
      render partial: 'referral_info', locals: {offer:offer, box: box}
    end
  end

  def ShowApprovedOffer(offer:)
      render partial: 'offer', locals: {offer:offer} if offer.present?
  end

end

#TODO there's an issue with offers thing - it's where it says submit instead of the correct text
