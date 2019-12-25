class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { render nothing: true, status: :not_found }
      format.html { redirect_to main_app.root_url, notice: exception.message, status: :not_found }
      format.js   { render nothing: true, status: :not_found }
    end
  end

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

  def set_instance(instance:,id:, object:)
    instance_variable_set("@#{instance}",Object.const_get(object).find(id))
  end

end
