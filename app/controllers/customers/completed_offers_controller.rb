class Customers::CompletedOffersController < ApplicationController
  load_and_authorize_resource :class => "Offer"

  before_action only: [:index] do
    set_instance(instance:"box", id:params[:box_id], object: :Box)
  end

  before_action only: [:update, :destroy, :show] do
    set_instance(instance:"offer", id:params[:id], object: :Offer)
  end #TODO this will create a possible problem REMINDER - when I look at this again tell myself why this might create a problem??

  def index
    @completed_offers = @box.old_offers
  end

  def update
    @offer.rotate_selection
    respond_to do |format|
      if @offer.save
        format.html { redirect_back(fallback_location: :index)}
        format.json { render :index, status: :ok  }
      else
        format.html { redirect_back(fallback_location: :index)}
        format.json {render json: @offer.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @offer.destroy
    respond_to do |format|
      format.html {redirect_back fallback_location: :index}
      format.json {head :no_content}
    end
  end

  def show

  end

  private

  def completed_offer_params
      params.permit(:selected_option)
  end

end
