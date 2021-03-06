class Customers::OffersController < ApplicationController
  load_and_authorize_resource
  skip_authorize_resource :only => :create
  skip_before_action :authenticate_user!, :only => [:create]

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
    @old_offers = @box.old_offers
    @active_offers = @box.active_offers
  end

  def edit
    #offers don't need to be edited in their own page - right now it's in a partial
  end

  def update
    respond_to do |format|
      if @offer.update(offer_params)
        if @offer.selected_option = "useful" && @offer.box.public == "true"
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
    @offer.options = ['useful', 'not useful', 'spam', 'need info']
    # @offer.tags = offer_params[:tags].split(' ') #TODO taking out tags from view as well since users won't be tagging anything most probably
    @offer.campaign = Campaign.first #TODO I'm not using campaign right now so I'm just setting it to a default
    @offer.approved = true
    @offer.public_options = ['send']
    @offer.save
    @offer.original_offer_id = @offer.id
    if current_user == @offer.box.user
      @offer.selected_option = 'useful'
      #TODO I am removing all options for customer sent things - just ads for now. no coupons or questions
      @offer.public_selected_option = 'send' #TODO I am assuming any offer that is created wants to be sent.
      #@offer.options = JSON.parse(offer_params[:options])
      @offer.active = false
      @offer.approved = true
      @offer.email_sent = true
    else
      @offer.active = true
      @offer.email_sent = false
    end
    #TODO I no longer provide option to attach image to make things simpler
    #@offer.image.attach offer_params[:image]

    @offer.setup_iframe(offer_params[:link]) if offer_params[:link].present?

    respond_to do |format|
      if @offer.save

        PropagateOfferWorker.perform_async(@offer.id) if @offer.public_selected_option.present?

        ApproveOfferWorker.perform_async(@offer.id)
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
                                  :received_commentary,
                                  :description,
                                  :tags,
                                  :image,
                                  :box_id,
                                  :campaign_id,
                                  :options,
                                  :link,
                                  :public_selected_option=>[])
  end

end
