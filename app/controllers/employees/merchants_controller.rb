class Employees::MerchantsController < ApplicationController
  load_and_authorize_resource
  before_action {ensure_role("admin","employee", "moderator")}

  def index
    @merchants = User.where(role:"merchant")
  end

end
