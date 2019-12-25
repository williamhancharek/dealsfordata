class OffersController < ApplicationController
  load_and_authorize_resource

  before_action only: [:show, :edit, :update, :destroy] do
    set_user('offer', params[:id])
  end

  #this is only for customers or whoever to view the offer

  def show
  end

  def index
    @offers = current_user.active_offers
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

  def edit
  end

  private

  def offer_params
    params.require(:offer).permit(:selected_option, :id)
  end

end
