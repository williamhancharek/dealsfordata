class Moderators::BoxesController < ApplicationController
  before_action {ensure_role("admin","moderator")}


  def index
    @boxes = Box.all
  end

  def show

  end

  def update

  end

end
