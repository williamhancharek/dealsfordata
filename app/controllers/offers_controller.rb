class OffersController < ApplicationController

  def show


  end

  def index
    @user = current_user
    @offer = user.get_offer



  end
end
