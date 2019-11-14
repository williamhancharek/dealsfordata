class Employees::Users::CustomersController < ApplicationController

  def index
    @customers = User.where(role:"customer")
  end
end
