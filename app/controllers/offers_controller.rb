class OffersController < ApplicationController

  def show
    
  end

  def index
    @user = current_user
    @offers = @user.get_offers
  end

end
