class Employees::MerchantsController < ApplicationController
  before_action {ensure_role("admin","employee", "moderator")}

  def index
    @merchants = User.where(role:"merchant")
  end

end
