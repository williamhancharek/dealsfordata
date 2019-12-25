class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { render nothing: true, status: :not_found }
      format.html { redirect_to main_app.root_url, notice: exception.message, status: :not_found }
      format.js   { render nothing: true, status: :not_found }
    end
  end

  before_action :authenticate_user! #TODO not necessary with cancancan right?


  private

  def after_sign_in_path_for(resource)
    case current_user.role
    when "customer"
      send("customer_user_boxes_path", current_user)
    when 'admin'
      send("admin_path",current_user)
    when 'employee'
      send("employee_home_path",current_user)
    when 'moderator'
      send("moderator_home_path",current_user)
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
