class Customer::BoxesController < ApplicationController
  before_action only: [:index] do
    set_instance(instance:'customer',
                        id:params[:user_id],
                    object: :User)
  end

  before_action only: [:show, :edit, :update, :destroy] do
    set_instance(instance:'box',id:params[:id],object: :Box)
  end

  def index
    @boxes = @customer.boxes
  end

  def new
    @box = Box.new
  end

  def create
    
  end

  def show
  end

  def edit
  end


  private

  def boxes_params
    #todo
  end

end
