class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_role


  private

  def after_sign_in_path_for(resource)
    send("#{resource.role}_path",current_user)
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

  def set_user(instance,id)
    instance_variable_set("@#{instance}",User.find(id))
  end

  def set_offer(instance,id)
    instance_variable_set("@#{instance}",Offer.find(id))
  end
  #TODO if I was legit I could combine set_user and set_offer into
  #a single method and use some metaprogramming or some such
end
