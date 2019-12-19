class Employees::BoxesController < ApplicationController
  before_action {ensure_role("admin","employee", "moderator")}

  def index
    if params[:id].blank?
      @boxes = current_user.assigned_boxes
    else #TODO I should be doing a check here to make sure that they can only see the id of their assigned users
      @user = User.find(params[:id])
      @boxes = @user.boxes
    end
  end

  def show

  end

  private

  def box_params

  end

end
