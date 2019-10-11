class CustomersController < ApplicationController

  def show
    @customer = User.find(params[:id])
    binding.remote_pry
  end
end
