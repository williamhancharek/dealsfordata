class Moderators::ModeratorsController < ApplicationController
  load_and_authorize_resource
  before_action {ensure_role("admin", "moderator")}

  def show

  end

end
