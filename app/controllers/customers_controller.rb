class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]


  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @customer.update(customer_params)
        flash[:success] = "successfully updated" #possibly delete this stupid message
        format.html { redirect_back(fallback_location: customer_path)}
        format.json { render :edit, status: :ok  }
      else
        flash[:warning] = "failed to update"
        format.html {render :edit}
        format.json {render json: @customer.errors, status: :unprocessable_entity}
      end
    end
  end

  private

  def set_customer
    @customer = User.find(params[:id])
  end

  def customer_params
    params.require(:user).permit(:keywords, :search_terms, :attributes)
  end

  def index #only employees and admin should be able to access

  end

  private



end
