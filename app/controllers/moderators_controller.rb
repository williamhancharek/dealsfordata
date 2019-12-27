class ModeratorsController < ApplicationController
  load_and_authorize_resource :class => "User"
  before_action {ensure_role("admin", "moderator")}

  def show

  end

end
