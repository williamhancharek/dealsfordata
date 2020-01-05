class Customers::BoxesController < ApplicationController
  load_and_authorize_resource

  def index
    @box = Box.new
    @boxes = current_user.boxes #overriding cancancan @boxes
    @box_count = @boxes.count
  end

  def edit
  end

  def update
    respond_to do |format|
      if @box.update(box_params)
        format.html { redirect_back fallback_location: :index}
        format.json {render :new, status: :create, location: @user} #I don't know what this means
      else
        format.html {render :index}
        format.json {render json: @box.errors, status: :unprocessable_entity}
      end
    end

  end

  def create #TODO I am not incorporating address for the time being
    @box = current_user.boxes.build(box_params)
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

  def show #TODO not using right now

  end

  def edit
  end

  def destroy
    @box.destroy
    respond_to do |format|
      format.html {redirect_to customer_boxes_path, notice: "box was successfully destroyed"}
      format.json {head :no_content}
    end
  end

  private

  def box_params
    params.require(:box).permit(:search_terms, :name, :keywords, :street, :city, :state, :country, :gender, :public, :foreign_box, :box_id, :allow_email, :background)
  end

end
