class Customer::BoxesController < ApplicationController
  before_action only: [:index] do
    {set_instance(instance:'customer', id:params[:user_id],object:User)}
  end

  def index

  end

  private

  def boxes_params
    #todo
  end


end
