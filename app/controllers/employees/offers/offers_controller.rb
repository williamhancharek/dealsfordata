class Employees::Offers::OffersController < ApplicationController

  def new
    @offer = Offer.new
    @boxes = Box.all
    if !(params[:campaign_id].blank?)
      @campaign = Campaign.find(params[:campaign_id])
    end #TODO I am trying to make the "new" form automatically select the campaign I am coming from,
    #if I am coming from the merchants --> campaigns --> new offer link - but it doesn't work..
    @campaigns = Campaign.all
  end

  def create #TODO stole this and I need to make sure it works
    @offer = Offer.new(offer_params)
    @offer.options = JSON.parse(offer_params[:options])
    @offer.tags = offer_params[:tags].split(' ')
    @offer.image.attach offer_params[:image]

    binding.pry_remote

    #TODO the above code smells

    respond_to do |format|
      if @offer.save
        format.html { redirect_back fallback_location: :new, notice: "Offer was successfully created"}
        format.json {render :new, status: :create, location: @user} #I don't know what this means
      else
        format.html {render :new}
        format.json {render json: @offer.errors, status: :unprocessable_entity}
      end
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:title,
                                  :description,
                                  :tags,
                                  :options,
                                  :selected_option,
                                  :box_id,
                                  :campaign_id)
  end
end
