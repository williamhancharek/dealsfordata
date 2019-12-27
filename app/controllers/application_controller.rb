class ApplicationController < ActionController::Base
  before_action :authenticate_user!
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
      send("customer_boxes_path")
    when 'admin'
      send("admin_path",current_user)
    when 'employee'
      send("employee_path",current_user)
    when 'moderator'
      send("moderator_path",current_user)
    end
  end

  def set_instance(instance:,id:, object:)
    instance_variable_set("@#{instance}",Object.const_get(object).find(id))
  end

  def ensure_box_owner(box_id:)
    @box = Box.find(box_id)
    if !(@box.user == current_user)
      flash[:alert] = "that wasn't your box!"
      redirect_to root_path
    end
  end

end
