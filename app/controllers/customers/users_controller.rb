class Customers::UsersController < ApplicationController
  load_and_authorize_resource

  def show
    @active = 4

  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = "successfully updated" #possibly delete this stupid message
        format.html { redirect_back(fallback_location: customer_user_path)}
        format.json { render :edit, status: :ok  }
      else
        flash[:warning] = "failed to update"
        format.html {render :edit}
        format.json {render json: @customer.errors, status: :unprocessable_entity}
      end
    end
  end


  private

  def user_params
    params.require(:user).permit(:search_terms, :allow_email, :name)
  end


end
