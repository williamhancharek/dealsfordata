class Customers::OffersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy, :index]
  before_action :set_offer, only: [:show, :edit, :update, :destroy]

  def index
    @offers = current_user.get_offers
  end

  def edit

  end

  def update
    respond_to do |format|
      if @offer.update(offer_params)
        flash[:success] = "successfully updated" #possibly delete this stupid message
        format.html { redirect_back(fallback_location: :index)}
        format.json { render :index, status: :ok  }
      else
        format.html { render :index}
        format.json {render json: @offer.errors, status: :unprocessable_entity}
      end
    end
  end

  def show
  end

  private
  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offer_params
    params.require(:offer).permit(:selected_option)
  end

end
#TODO ending here - need to review navbar to make sure customer offers is navigating to the right controller
