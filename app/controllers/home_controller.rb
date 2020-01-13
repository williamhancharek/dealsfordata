class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]

  def index
    @new_box = current_user.boxes.build if current_user.present?
    if current_user.present?
      @boxes = Box.where("public= ? AND status= ? AND user_id != ?", 1, "active", current_user.id).take(12)
    else
      @boxes = Box.where("public= ? AND status= ?", 1, "active").take(12)
    end
    @active = 1
  end

end
