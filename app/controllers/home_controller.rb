class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]

  def index
    @boxes = Box.where(public: "true").take(12)
  end

end
