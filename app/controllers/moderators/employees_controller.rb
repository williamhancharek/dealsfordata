class Moderators::EmployeesController < ApplicationController
  # load_and_authorize_resource :class => "User"
  before_action {ensure_role("admin","moderator")}

  def index
    @employees = User.where(role:"employee")
  end

  def edit
    @employee = User.find(params[:id])

  end

  def update
    @employee = User.find(params[:id])
    @employee.update(employee_params)
    respond_to do |format|
      if @employee.save
        format.html {redirect_back(fallback_location: :edit, notice: "user was successfully updated")}
        format.json {render :edit, location: @user}
      else
        format.html {render :edit}
        format.json {render json: @employee.errors, status: :unprocessable_entity}
      end
    end
  end

  private

  def employee_params
    params.require(:user).permit(:assigned_boxes)
  end

end
