class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]


  def show
  
  end

  def edit

  end

  def update

  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:tags, :search_terms)
  end

end
