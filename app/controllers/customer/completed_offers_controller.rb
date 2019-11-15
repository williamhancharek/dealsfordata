class Customer::CompletedOffersController < ApplicationController
  before_action only: [:index] do
    set_instance(instance:"box", id:params[:box_id], object: :Box)
  end

  before_action only: [:update] do
    set_instance(instance:"offer", id:params[:id], object: :Offer)
  end

  def index
    @completed_offers = @box.old_offers
  end

  def update
    respond_to do |format|
      if @offer.update(completed_offer_params)
        flash[:success] = "successfully updated" #possibly delete this stupid message
        format.html { redirect_back(fallback_location: :index)}
        format.json { render :index, status: :ok  }
      else
        format.html { render :index}
        format.json {render json: @offer.errors, status: :unprocessable_entity}
      end
    end
  end

  private

  def completed_offer_params
      params.require(:offer).permit(:selected_option)
  end

end
