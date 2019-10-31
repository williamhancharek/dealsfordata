class Employees::Customers::OffersController < ApplicationController
  before_action :ensure_employee #TODO this is not DRY
  before_action :set_offer, only: [:show, :edit, :update, :destroy, :create, :new]
  before_action :set_customer, only: [:index] #this is because an offer should only be viewed in the
  #context of a particular customer

  def index
    @customer_offers = @customer.customer_offers
  end

  def show

  end

  def edit

  end

  def update

  end

  def new

  end

  def create

  end

  def destroy

  end

  private

  def ensure_employee #TODO there is def a better way to do this via cancancan
    if !(current_user.role == "admin" || "employee")
      flash[:warning] = "not allowed access"
      redirect_to root_path
    end
  end

  def customer_params
    params.permit(:customer_id)
  end

  def set_customer
    @customer = User.find(params[:customer_id])
  end

end
