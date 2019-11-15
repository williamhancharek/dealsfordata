class Customer::OffersController < ApplicationController
  before_action only: [:index] do
    set_instance(instance:"box",id: params[:box_id], object: :Box)
  end
  before_action only: [:show, :edit, :update, :destroy] do
    set_instance(instance: "offer", id: params[:id], object: :Offer)
  end

  def index
    @offers = @box.active_offers
  end

  def edit
    #offers don't need to be edited in their own page - right now it's in a partial
  end

  def update
    binding.pry_remote
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
    params.require(:offer).permit(:selected_option, :options)
  end

end
#TODO ending here - need to review navbar to make sure customer offers is navigating to the right controller
