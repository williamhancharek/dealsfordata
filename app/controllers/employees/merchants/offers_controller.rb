class Employees::Merchants::OffersController < ApplicationController
  before_action {ensure_role("employee")}

  def index

  end

  private
  
end
