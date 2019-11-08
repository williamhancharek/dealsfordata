class Employees::Customers::OffersController < ApplicationController
  before_action {ensure_role("employee")} #TODO this is not DRY
  before_action only: [:index] do #this is because an offer should only be viewed in the
    set_user("customer", params[:customer_id])
  end
  #context of a particular customer

  def index
    @customer_offers = @customer.customer_offers
  end

  private

end
