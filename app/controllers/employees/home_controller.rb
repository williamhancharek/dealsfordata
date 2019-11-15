class Employees::HomeController < ApplicationController
  before_action {ensure_role("admin","employee")}


  def show

  end

end
