class OfferMailer < ApplicationMailer
  default from: 'offers@dealsfordata.com'

  def offer_email
    @offer = Offer.find(params[:offer_id])
    @box = Box.find(@offer.box.id)
    @user=User.find(@box.user.id)
    @url = customer_box_offers_url(@box.id)
    mail(to: @user.email, subject: "new offer: #{@offer.title} for #{@box.name}") do |format|
          format.text
          format.html
    end
  end
end
