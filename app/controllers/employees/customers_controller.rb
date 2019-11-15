class Employees::CustomersController < ApplicationController
  before_action {ensure_role("admin","employee")}


  def index
    @customers = User.where(role:"customer")
  end
end
