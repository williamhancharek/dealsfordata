class Customers::Offers::CompletedController < ApplicationController
  before_action :set_customer, only: [:index]

  def index
    @offers = current_user.get_old_offers
  end
end
