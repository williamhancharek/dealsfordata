class Customers::SubscribersController < ApplicationController
  load_and_authorize_resource :class => "Box"
  before_action only: [:index] do
    set_instance(instance:"box",id: params[:box_id], object: :Box)
  end

  before_action only: [:index] do
    ensure_box_owner(box_id: params[:box_id])
  end

  def index
    @subscriptions = @box.subscribers
  end

end
