class EmployeesController < ApplicationController
  load_and_authorize_resource
  before_action {ensure_role("admin","employee", "moderator")}

  def show
  end
end
