class Employees::Boxes::OffersController < ApplicationController
  before_action only: [:index] do
    set_instance(instance:"box",id: params[:box_id], object: :Box)
  end

  def index
    @offers = @box.active_offers
  end
end
