class EmployeesController < ApplicationController
  before_action {ensure_role("admin","employee", "moderator")}

  def show
  end
end
