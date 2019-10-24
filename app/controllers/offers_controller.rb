class OffersController < ApplicationController
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  def show
  end

  def new
  end

  def index
    @user = current_user
    @offers = @user.get_offers
  end

  def create
  end

  def update
    respond_to do |format|
      if @offer.update(offer_params)
        flash[:success] = "successfully updated" #possibly delete this stupid message
        format.html { redirect_back(fallback_location: offers_path)}
        format.json { render :index, status: :ok  }
      else
        format.html { render :index}
        format.json {render json: @offer.errors, status: :unprocessable_entity}
      end
    end

  end

  def destroy
  end

  def edit
  end

  private

  def offer_params
    params.require(:offer).permit(:selected_option, :id)
  end

  def set_offer
    @offer = Offer.find(params[:id])
  end

end
