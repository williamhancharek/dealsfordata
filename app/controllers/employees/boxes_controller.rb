class Employees::BoxesController < ApplicationController

  def index

    if params[:id].blank?
      @boxes = Box.all
    else
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
