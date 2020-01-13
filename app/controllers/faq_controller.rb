class FaqController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]

  def index
    @active = 3
  end
end
