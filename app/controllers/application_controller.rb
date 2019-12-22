class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :set_role

  private

  def after_sign_in_path_for(resource)
    case current_user.role
    when "customer"
      send("customer_user_boxes_path", current_user)
    else
      send("#{resource.role}_home_path",current_user)
    end
  end

  def set_role
    if current_user == nil
      @user_role = "logged_out"
    else
      @user_role = current_user.role
    end
  end

  def ensure_role(*roles) #TODO I should use cancancan
    if !(roles.include?(current_user.role))
      flash[:warning] = "not allowed access"
      redirect_to root_path
    end
  end

  def ensure_box_owner(id) #TODO - I tihnk this is my shitty workaround for not using cancancan properly
    #This should probably be switched over to using CANCANCAN properly
    box = Box.find(id)
    if box.user != current_user
      flash[:warning] = "not allowed access"
      redirect_to root_path
    end
  end

  def ensure_offer_owner(id) #TODO switch to cancancan
    offer = Offer.find(id)
    if offer.box.user != current_user
      flash[:warning] = "not allowed access"
      redirect_to root_path
    end
  end

  def ensure_user(id) #should replace with cancancan
    user = User.find(id)
    if user != current_user
      flash[:warning] = "not allowed access"
      redirect_to root_path
    end
  end

  def set_instance(instance:,id:, object:)
    instance_variable_set("@#{instance}",Object.const_get(object).find(id))
  end

end
