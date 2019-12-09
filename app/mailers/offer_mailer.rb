class OfferMailer < ApplicationMailer
  default from: 'offers@dealsfordata.com'

  def offer_email (user_id, offer_id, box_id)
    @user = User.find(user_id)
    @offer = Offer.find(offer_id)
    @box = Box.find(box_id)
    @url = customer_box_offers_url(box_id)

    mail(to: @user.email, subject: "new offer: #{@offer.title} for #{@box.name}") do |format|
          format.text
          format.html
    end
  end
end
