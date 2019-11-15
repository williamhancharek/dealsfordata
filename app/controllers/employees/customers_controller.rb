class Employees::CustomersController < ApplicationController

  def index
    @customers = User.where(role:"customer")
  end
end
