class Employees::Users::MerchantsController < ApplicationController

  def index
    @merchants = User.where(role:'merchant')
  end
end
