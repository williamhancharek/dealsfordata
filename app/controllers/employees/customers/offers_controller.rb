class Employees::Customers::OffersController < ApplicationController
  before_action :ensure_employee #TODO this is not DRY
  before_action :set_customer, only: [:index] #this is because an offer should only be viewed in the
  #context of a particular customer

  def index
    @customer_offers = @customer.customer_offers
  end

  private

  def ensure_employee #TODO there is def a better way to do this via cancancan
    if !(current_user.role == "admin" || "employee")
      flash[:warning] = "not allowed access"
      redirect_to root_path
    end
  end

  def set_customer
    @customer = User.find(params[:customer_id])
  end

end
