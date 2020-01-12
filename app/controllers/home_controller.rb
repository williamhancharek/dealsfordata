class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]

  def index
    @box = current_user.boxes.build if current_user.present?
    @boxes = Box.where(public: "true").take(12)
    @active = 1
  end

end
