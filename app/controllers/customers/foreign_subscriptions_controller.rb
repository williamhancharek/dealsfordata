class Customers::ForeignSubscriptionsController < ApplicationController
  load_and_authorize_resource :class => "Subscription"

  before_action only: [:index] do
    set_instance(instance:"box",id: params[:box_id], object: :Box)
  end

  def index
    !(params[:originating_box_id].empty?) ? @originating_box = Box.find(params[:originating_box_id]) : nil
    @subscriptions = @box.subscribing
  end

  private

  def foreign_subscriptions_params

  end

end
