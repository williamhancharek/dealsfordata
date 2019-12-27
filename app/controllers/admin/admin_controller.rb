class Admin::AdminController < ApplicationController
  load_and_authorize_resource :class => "User"
  before_action {ensure_role("admin")}


  def show

  end

end
