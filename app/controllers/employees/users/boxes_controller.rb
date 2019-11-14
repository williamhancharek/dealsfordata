class Employees::Users::BoxesController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy, :index] do
    set_instance(instance:"user", id:params[:user_id],object: :User)
  end

  def index
    @boxes = @user.boxes
  end

end
