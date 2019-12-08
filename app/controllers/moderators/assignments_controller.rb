class Moderators::AssignmentsController < ApplicationController
  before_action {ensure_role("admin","moderator")}
  before_action only: [:destroy] do
    set_instance(instance:'assignment',
                        id:params[:id],
                    object: :Assignment)
  end

  def create
    @assignment = Assignment.new(box_id: assignment_params[:box_id], user_id: assignment_params[:user])
    respond_to do |format|
      if @assignment.save
        format.html { redirect_back fallback_location: moderator_boxes_url}
        format.json {render :new, status: :create, location: @user} #TODO - this is wrong and I don't know what this means
      else
        format.html {render :new} #TODO I shouldn't be rendering new since new doesn't exist
        format.json {render json: @box.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html {redirect_back fallback_location: moderator_boxes_url}
      format.json {head :no_content}
    end
  end

  private

  def assignment_params
    params.require(:assignment).permit(:user, :box_id)
  end

end
