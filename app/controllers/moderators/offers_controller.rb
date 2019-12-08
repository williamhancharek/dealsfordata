class Moderators::OffersController < ApplicationController
  before_action {ensure_role("admin","moderator")}
  before_action only: [:update, :destroy, :show] do
    set_instance(instance:'offer',id:params[:id],object: :Offer)
  end

  before_action only: [:index] do
    set_instance(instance:'box',id:params[:box_id],object: :Box)
  end

  def index
    @active_offers = @box.active_offers
  end

  def show

  end

  def update
    respond_to do |format|
      if @offer.update(offer_params)
        flash[:success] = "successfully updated" #possibly delete this stupid message
        format.html { redirect_back(fallback_location: :index)}
        format.json {render :index, status: :ok} #TODO fix this
      else
        flash[:warning] = "failed to update"
        format.html {redirect_back(fallback_location: :index)}
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

  private

  def offer_params
    params.require(:offer).permit(:approved)

  end

end
