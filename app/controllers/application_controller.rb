class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  def after_sign_in_path_for(resource)
    if resource.role == 'customer'
      customer_path(current_user)
    elsif resource.role == "merchant"
      merchant_path(current_user)
    elsif resource.role == "employee"
      employee_path(current_user)
    elsif resource.role == "admin"
      admin_users_path
    end
  end

end
