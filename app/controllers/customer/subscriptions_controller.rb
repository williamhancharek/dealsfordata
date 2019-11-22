class Customer::SubscriptionsController < ApplicationController
  before_action only: [:index] do
    set_instance(instance:"box",id: params[:box_id], object: :Box)
  end

  def index
    @subscriptions = @box.subscribers
  end

  def create
    binding.pry_remote

  end

  private

  def subscription_params #TODO - this doesn't have "require" because the create link doesn't have the subscription thing.. I think
    #it's because I'm passing extra variables
    params.permit(:box_id, :subscriber_id)
  end

end
