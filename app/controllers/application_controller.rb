class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_role

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

  private

  def set_role
    if current_user == nil
      @user_role = "logged_out"
    else
      @user_role = current_user.role
    end
  end

  def ensure_role(*roles)
    if !(current_user.role == "admin" || "employee")
      flash[:warning] = "not allowed access"
      redirect_to root_path
    end
  end

  def set_customer

  end

end
