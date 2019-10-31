class Employees::Customers::CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]
  before_action :ensure_employee
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

  def set_customer
    @customer = User.find(params[:id])
  end

  def customer_params
    params.require(:user).permit(:keywords, :search_terms, :attributes, :modifiers)
  end

  def ensure_employee #TODO there is def a better way to do this via cancancan
    if !(current_user.role == "admin" || "employee")
      flash[:warning] = "not allowed access"
      redirect_to root_path
    end
  end

end