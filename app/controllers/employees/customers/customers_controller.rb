class Employees::Customers::CustomersController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy] do
    set_user("customer", params[:id])
  end

  before_action {ensure_role('employee')}

  def show

  end

  def edit

  end

  def update
    respond_to do |format|
      if @customer.update(customer_params)
        flash[:success] = "successfully updated" #possibly delete this stupid message
        format.html { redirect_back(fallback_location: :edit)}
        format.json { render :edit, status: :ok  }
      else
        flash[:warning] = "failed to update"
        format.html {render :edit}
        format.json {render json: @customer.errors, status: :unprocessable_entity}
      end
    end
  end

  def index #this should only be accessed by employees and maybe admins?
    @customers = User.where(role: "customer")
  end

  private


  def customer_params
    params.require(:user).permit(:keywords, :search_terms, :attributes, :modifiers)
  end

end
