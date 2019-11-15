class Employees::MerchantsController < ApplicationController

  def index
    binding.pry_remote
    @merchants = User.roles.where(role:"merchant")
  end

end
