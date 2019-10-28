class Admin::UsersController < ApplicationController
  before_action :ensure_admin
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @users = User.all
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        flash[:success] = "successfully updated" #possibly delete this stupid message
        format.html { redirect_back(fallback_location: admin_user_path(@user))}
        format.json { render :edit, status: :ok  }
      else
        flash[:warning] = "failed to update"
        format.html {render :edit}
        format.json {render json: @user.errors, status: :unprocessable_entity}
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

  end
  #
  # def create
  #   @blah = Blah.new(blah_params)
  #
  #   respond_to do |format|
  #     if @blah.save
  #       format.html { redirect_to @blah, notice: 'Blah was successfully created.' }
  #       format.json { render :show, status: :created, location: @blah }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @blah.errors, status: :unprocessable_entity }
  #     end
  #   end
  end


  def destroy
  end

  # f destroy
  #   @blah.destroy
  #   respond_to do |format|
  #     format.html { redirect_to blahs_url, notice: 'Blah was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end


  private

  def user_params
    params.require(:user).permit(:role, :keywords, :search_terms, :attributes, :modifiers)
  end

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_admin #TODO there is def a better way to do this via cancancan
    if !(current_user.role == "admin")
      flash[:warning] = "not allowed access"
      redirect_to root_path
    end
  end

end
