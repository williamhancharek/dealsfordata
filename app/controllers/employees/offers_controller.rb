class Employees::OffersController < ApplicationController
  load_and_authorize_resource
  before_action {ensure_role("admin","employee", "moderator")}

  before_action only: [:index, :new] do
    set_instance(instance:"box",id: params[:box_id], object: :Box)
  end

  def index
    @offers = @box.offers
    @offer = @box.offers.build
  end

  def new
    @offer = @box.offers.build
    @boxes = Box.all
    @campaign_name = Campaign.all.map {|t| [t.name, t.id]} #TODO this is a shit filter; also not using campaign name right now
  end

  def create
    @offer = Offer.new(offer_params)
    @offer.options = JSON.parse(offer_params[:options])
    @offer.public_options = ['send']
    @offer.tags = offer_params[:tags].split(' ')
    @offer.image.attach offer_params[:image]
    @offer.campaign = Campaign.first #TODO this is setting default campaign.. take it out when I actually need to have campaigns

    @offer.setup_iframe(offer_params[:link]) if offer_params[:link].present?

    respond_to do |format|
      if @offer.save
        format.html {redirect_back fallback_location: :new, notice: "offer was successfully created"}
        format.json {render :new, status: :create, location: @user}
      else
        format.html {redirect_back fallback_location: :index, alert: "offer was not created"}
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
                                  :link,
                                  :commentary,
                                  :options)
  end

end
