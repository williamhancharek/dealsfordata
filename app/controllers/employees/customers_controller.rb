class Employees::CustomersController < ApplicationController
  before_action {ensure_role("admin","employee", "moderator")}


  def index
    @customers = current_user.assigned_customers
  end
end
