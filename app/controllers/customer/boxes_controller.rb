class Customer::BoxesController < ApplicationController
  before_action only: [:index, :create] do
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

  def edit
  end

  def update
    respond_to do |format|
      if @box.update(box_params)
        format.html { redirect_back fallback_location: :edit, notice: "box was successfully updated"}
        format.json {render :new, status: :create, location: @user} #I don't know what this means
      else
        format.html {render :edit}
        format.json {render json: @box.errors, status: :unprocessable_entity}
      end
    end

  end

  def create
    @box = @customer.boxes.build(box_params)
    respond_to do |format|
      if @box.save
        format.html { redirect_back fallback_location: :new, notice: "box was successfully created"}
        format.json {render :new, status: :create, location: @user} #I don't know what this means
      else
        format.html {render :new}
        format.json {render json: @box.errors, status: :unprocessable_entity}
      end
    end

  end

  def show
  end

  def edit
  end


  private

  def box_params
    params.require(:box).permit(:search_terms, :name, :keywords, :street, :city, :state, :country)
    #todo
  end

end