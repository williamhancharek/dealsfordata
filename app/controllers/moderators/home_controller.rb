class Moderators::HomeController < ApplicationController
  before_action {ensure_role("admin","moderator")}

  def show

  end

end
