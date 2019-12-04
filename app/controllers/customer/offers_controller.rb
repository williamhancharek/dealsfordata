class Customer::OffersController < ApplicationController
  before_action only: [:index, :new] do
    set_instance(instance:"box",id: params[:box_id], object: :Box)
  end
  before_action only: [:show, :edit, :update, :destroy] do
    set_instance(instance: "offer", id: params[:id], object: :Offer)
  end

  def new
    @offer = @box.offers.build
    @offer.referrer = [@box.id]
    @offer.campaign = Campaign.first
  end

  def index
    @offers = @box.active_offers
  end

  def edit
    #offers don't need to be edited in their own page - right now it's in a partial
  end

  def update
    respond_to do |format|
      if @offer.update(offer_params)
        if !(@offer.public_selected_option.nil?)
          PropagateOfferWorker.perform_async(@offer.id, @offer.box.id)
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
    @offer = Offer.new(offer_params)
    @offer.options = JSON.parse(offer_params[:options])
    @offer.public_options = ['send', 'extra hot!']
    @offer.tags = offer_params[:tags].split(' ')
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
                                  :public_selected_option,
                                  :commentary,
                                  :title,
                                  :description,
                                  :tags,
                                  :image,
                                  :box_id,
                                  :campaign_id,
                                  :options)
  end

end
