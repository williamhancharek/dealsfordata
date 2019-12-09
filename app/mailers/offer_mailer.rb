class OfferMailer < ApplicationMailer
  default from: 'offers@dealsfordata.com'

  def offer_email
    @user = params[:user]
    @offer = params[:offer]

    mail(to: @user.email, subject: "new offer: @offer.title") do |format|
          format.text
          format.html
    end
  end
end
