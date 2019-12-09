class Customer::UsersController < ApplicationController
  before_action only: [:show, :edit, :update] do
    set_instance(instance:"customer",id:params[:id],object: :User)
  end

  def show

  end

  def edit
  end

  def update
    respond_to do |format|
      if @customer.update(customer_params)
        flash[:success] = "successfully updated" #possibly delete this stupid message
        format.html { redirect_back(fallback_location: customer_home_path)}
        format.json { render :edit, status: :ok  }
      else
        flash[:warning] = "failed to update"
        format.html {render :edit}
        format.json {render json: @customer.errors, status: :unprocessable_entity}
      end
    end
  end


  private

  def customer_params
    params.require(:user).permit(:keywords, :search_terms, :attributes, :allow_email)
  end


end
