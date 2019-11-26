class Customer::SubscriptionsController < ApplicationController
  before_action only: [:index] do
    set_instance(instance:"box",id: params[:box_id], object: :Box)
  end

  before_action only: [:destroy] do
    set_instance(instance:"sub",id: params[:id], object: :Subscription)
  end

  def index
      case params[:format]
      when "subscribers"
        @subscriptions = @box.subscribers
      when "subscriptions"
          @subscriptions = @box.subscribing
      end
  end

  def create
    @sub = Subscription.new({subscriber: Box.find(params[:subscriber_id]), subscribing: Box.find(params[:box_id])})
    respond_to do |format|
      if @sub.save
        format.html { redirect_back fallback_location: customer_user_boxes_url(current_user)}
        format.json {render :new, status: :create, location: @user} #I don't know what this means
      else
        format.html {render :new}
        format.json {render json: @box.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @sub.destroy
    respond_to do |format|
      format.html {redirect_back fallback_location: customer_user_boxes_url(current_user)}
      format.json {head :no_content}
    end
  end

  private

  def subscription_params #TODO - this doesn't have "require" because the create link doesn't have the subscription thing.. I think
    #it's because I'm passing extra variables
    params.permit(:box_id, :subscriber_id)
  end

end
