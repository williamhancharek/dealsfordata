class Employees::Merchants::OffersController < ApplicationController
  before_action :ensure_employee

  def index

  end

  private 
  def ensure_employee #TODO there is def a better way to do this via cancancan
    if !(current_user.role == "admin" || "employee")
      flash[:warning] = "not allowed access"
      redirect_to root_path
    end
  end
end
