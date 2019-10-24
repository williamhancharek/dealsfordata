class OffersController < ApplicationController

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
    binding.pry_remote
    @offer = Offer.find(offer_params)

    respond_to do |format|
      if @offer.update(offer_params)
        redirect_to offers_path
      else
        flash[:warning] = "failed"
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
