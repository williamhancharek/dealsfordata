class CustomersController < ApplicationController

  def show
    @customer = User.find(params[:id])
  end
end
