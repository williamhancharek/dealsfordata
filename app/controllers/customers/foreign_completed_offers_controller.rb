class Customers::ForeignCompletedOffersController < ApplicationController
  load_and_authorize_resource :class => "Offer"

  before_action only: [:index] do
    set_instance(instance:"box",id: params[:box_id], object: :Box)
  end

  def index

  end

end
