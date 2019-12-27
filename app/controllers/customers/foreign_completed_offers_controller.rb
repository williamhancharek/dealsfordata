class Customers::ForeignCompletedOffersController < ApplicationController
  load_and_authorize_resource :class => "Offer"

  before_action only: [:index] do
    set_instance(instance:"box",id: params[:box_id], object: :Box)
  end

  def index
    @completed_offers = @box.old_offers
    !(params[:originating_box_id].empty?) ? @originating_box = Box.find(params[:originating_box_id]) : nil
    @subscriptions = @box.subscribing
  end

end
