class Customers::SubscriptionsController < ApplicationController
  load_and_authorize_resource

  before_action only: [:index] do
    set_instance(instance:"box",id: params[:box_id], object: :Box)
  end

  before_action only: [:index] do
    ensure_box_owner(box_id: params[:box_id])
  end

  def index
    @subscriptions = @box.subscribing
  end

  def create
    @subscription.update(subscription_params)
    respond_to do |format|
      if @subscription.save
        format.html { redirect_back fallback_location: customer_boxes_url}
        format.json {render :new, status: :create, location: @user} #I don't know what this means
      else
        format.html {render :new}
        format.json {render json: @box.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @subscription.destroy
    respond_to do |format|
      format.html {redirect_back fallback_location: customer_boxes_url}
      format.json {head :no_content}
    end
  end

  private

  def subscription_params #TODO - this doesn't have "require" because the create link doesn't have the subscription thing.. I think
    #it's because I'm passing extra variables
    params.permit(:subscribing_id, :subscriber_id)
  end

end
