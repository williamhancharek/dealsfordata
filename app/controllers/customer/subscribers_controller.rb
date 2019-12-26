class Customer::SubscribersController < ApplicationController
  load_and_authorize_resource :class => "Box"

  def index

  end

end
