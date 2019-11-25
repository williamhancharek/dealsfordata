class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_role

  private

  def after_sign_in_path_for(resource)
    send("#{resource.role}_home_path",current_user)
  end

  def set_role
    if current_user == nil
      @user_role = "logged_out"
    else
      @user_role = current_user.role
    end
  end

  def ensure_role(*roles)
    if !(roles.include?(current_user.role))
      flash[:warning] = "not allowed access"
      redirect_to root_path
    end
  end

  def ensure_owner(id)
    box = Box.find(id)
  end

  def set_instance(instance:,id:, object:)
    instance_variable_set("@#{instance}",Object.const_get(object).find(id))
  end

end
