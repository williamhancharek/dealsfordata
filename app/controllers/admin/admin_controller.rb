class Admin::AdminController < ApplicationController
  before_action {ensure_role("admin")}

  def show

  end

end
