class Employees::OffersController < ApplicationController
  before_action {ensure_role("admin","employee")}

  before_action only: [:index] do
    set_instance(instance:"box",id: params[:box_id], object: :Box)
  end

  def index
    @offers = @box.offers
  end

  def new
    @offer = Offer.new
    @boxes = Box.all
    @campaigns = Campaign.all #TODO this is a shit filter
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.options = JSON.parse(offer_params[:options])
    @offer.tags = offer_params[:tags].split(' ')
    @offer.image.attach offer_params[:image]

    respond_to do |format|
      if @offer.save
        format.html {redirect_back fallback_location: :new, notice: "offer was successfully created"}
        format.json {render :new, status: :create, location: @user}
      else
        format.html {render :new, notice: "offer was not created"}
        format.json {render json: @offer.errors, status: :unprocessable_entity}
      end
    end
  end

  private

  def offer_params
    params.require(:offer).permit(:title,
                                  :description,
                                  :tags,
                                  :image,
                                  :box_id,
                                  :campaign_id,
                                  :options)
  end

end
