class Customer::BoxesController < ApplicationController
  before_action only: [:index, :create] do
    set_instance(instance:'customer',id:params[:user_id],object: :User)
  end

  before_action only: [:show, :edit, :update, :destroy] do
    set_instance(instance:'box',id:params[:id],object: :Box)
  end

  def index
    @box = Box.new
    if params[:foreign_box] == "true"
      @customer_box = Box.find(params[:box_id])

      if params[:subscribers] == "true"
        @boxes = @customer_box.subscribers
      elsif params[:subscribers] == "false"
        @boxes = Box.where("user_id != ?", @customer.id)
      end

      @box_links = "foreign_box_links"
      @title = "foreign_box_index_title"

    else
      @boxes = @customer.boxes
      if @boxes.empty?
        @box_count = 0
        @welcome_phrase = "To get started, create a box and write down what you're browsing for"
      else
        @box_count = @boxes.count
        @welcome_phrase = "Welcome back, #{current_user.name}!"
      end
      @box_links = "customer_box_links"
      @title = "customer_box_index_title"
    end
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

  def create #TODO I am not incorporating address for the time being
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

  def destroy
    @box.destroy
    respond_to do |format|
      format.html {redirect_to customer_user_boxes_path(current_user), notice: "box was successfully destroyed"}
      format.json {head :no_content}
    end
  end

  private

  def box_params
    params.require(:box).permit(:search_terms, :name, :keywords, :street, :city, :state, :country, :gender, :public, :foreign_box, :box_id, :allow_email)
  end

end
