class Customers::CompletedOffersController < ApplicationController
  before_action only: [:index] do
    set_user("customer", params[:customer_id])
  end

  def index
    @offers = current_user.get_old_offers
  end
end
