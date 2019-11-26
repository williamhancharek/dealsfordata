module Customer::OffersHelper

  def sendOffer(offer:, f:)
    if offer.box.public?
      render partial: "public_offer_selection", locals: {f: f, offer: offer}
    end
  end

end

#TODO there's an issue with offers thing - it's where it says submit instead of the correct text
