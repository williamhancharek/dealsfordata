class Customer::OffersController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy, :index] do
    set_user("customer", params[:customer_id])
  end
  before_action only: [:show, :edit, :update, :destroy] do
    set_offer("offer", params[:id])
  end

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

  def offer_params
    params.require(:offer).permit(:selected_option)
  end

end
#TODO ending here - need to review navbar to make sure customer offers is navigating to the right controller
