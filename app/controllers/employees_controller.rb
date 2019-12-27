class EmployeesController < ApplicationController
  load_and_authorize_resource :class => "User"
  # before_action {ensure_role("admin","employee", "moderator")}

  def show
  end
end
