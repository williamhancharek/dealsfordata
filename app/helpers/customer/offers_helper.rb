module Customer::OffersHelper

  def sendOffer(offer:, f:)
    if offer.box.public?
      render partial: "public_offer_selection", locals: {f: f, offer: offer}
    end
  end

  def referralInfo(offer:)
    if !(offer.original_offer_id.nil?)
      box = Box.find(offer.referrer.last)
      render partial: 'referral_info', locals: {offer:offer, box: box}
    end
  end

  def ShowApprovedOffer(offer:)
    if offer.nil?
    else
      render partial: 'offer', locals: {offer:offer}
    end
  end

end

#TODO there's an issue with offers thing - it's where it says submit instead of the correct text
