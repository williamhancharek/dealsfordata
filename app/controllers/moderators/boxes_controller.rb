class Moderators::BoxesController < ApplicationController
  load_and_authorize_resource
  before_action {ensure_role("admin","moderator")}
  before_action only: [:show] do
    set_instance(instance:'box',id:params[:id],object: :Box)
  end

  def index
    @boxes = Box.all
    @assignment = Assignment.new
    @employees=User.where(role: "employee").map {|t| [t.email,t.id]}
  end

  def show

  end

  def update

  end

end
