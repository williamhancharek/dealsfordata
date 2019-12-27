class Customers::OffersController < ApplicationController
  load_and_authorize_resource

  before_action only: [:index, :new] do
    set_instance(instance:"box",id: params[:box_id], object: :Box)
  end

  def new
    @offer = @box.offers.build
    @offer.referrer = [@box.id]
    @offer.campaign = Campaign.first
  end

  def index
    @offer = @box.approved_active_offer
    @approved_count = @box.approved_active_offers.count
  end

  def edit
    #offers don't need to be edited in their own page - right now it's in a partial
  end

  def update
    respond_to do |format|
      if @offer.update(offer_params)
        if !(@offer.public_selected_option.nil?)
          PropagateOfferWorker.perform_async(@offer.id)
        end
        flash[:success] = "successfully updated" #possibly delete this stupid message
        format.html { redirect_back(fallback_location: :index)}
        format.json { render :index, status: :ok  }
      else
        format.html {redirect_back(fallback_location: :index, alert: "offer didn't update")}
        format.json {render json: @offer.errors, status: :unprocessable_entity}
      end
    end
  end

  def show
  end

  def create
    #TODO this has to be made so that after creating the offer, the person automatically has it listed in completed offers and it's sent
    @offer = Offer.new(offer_params)
    @offer.options = JSON.parse(offer_params[:options])
    @offer.public_options = ['send']
    @offer.tags = offer_params[:tags].split(' ')
    @offer.active = true
    @offer.email_sent = true
    @offer.approved = true
    @offer.campaign = Campaign.first
    @offer.image.attach offer_params[:image]
    respond_to do |format|
      if @offer.save
        format.html {redirect_back fallback_location: :index, notice: "offer was successfully created"}
        format.json {render :new, status: :create, location: @user}
      else
        format.html {redirect_back fallback_location: :index, alert: "offer was not created"}
        format.json {render json: @offer.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
  end

  private

  def offer_params
    params.require(:offer).permit(:selected_option,
                                  :options,
                                  :commentary,
                                  :title,
                                  :description,
                                  :tags,
                                  :image,
                                  :box_id,
                                  :campaign_id,
                                  :options,
                                  :public_selected_option=>[])
  end

end
