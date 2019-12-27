class Employees::CustomersController < ApplicationController
  load_and_authorize_resource  :class => "User"
  before_action {ensure_role("admin","employee", "moderator")}


  def index
    @customers = current_user.assigned_customers
  end

end
