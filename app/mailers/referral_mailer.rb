class ReferralMailer < ApplicationMailer
  default from: 'offers@dealsfordata.com'

  def referral_email
    @offer = Offer.find(params[:offer_id])
    @box = Box.find(@offer.box.id)
    @user=User.find(@box.user.id)
    @referrer = Box.find(@offer.referrer.last)
    @url = customer_box_offers_url(@box.id)
    mail(to: @user.email, subject: "new offer: #{@offer.title} for #{@box.name}") do |format|
          format.text
          format.html
    end
  end
end
