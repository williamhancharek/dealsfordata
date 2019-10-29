class Employees::CustomersController < ApplicationController

  def show
  end

  def edit
  end

  def index #this should only be accessed by employees and maybe admins?
    @customers = User.where(role: "customer")
  end

end
