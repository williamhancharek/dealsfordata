class Admin::UsersController < ApplicationController
  load_and_authorize_resource

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
    @user.attach_identicon
    respond_to do |format|
      if @user.save
        format.html { redirect_back fallback_location: :index, notice: "User was successfully created"}
        format.json {render :new, status: :create, location: @user} #I don't know what this means
      else
        format.html {render :new}
        format.json {render json: @blah.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html {redirect_to admin_users_url, notice: "User was successfully destroyed"}
      format.json {head :no_content}
    end
  end

  private
  def user_params
    params.require(:user).permit(:role,
                                 :keywords,
                                 :search_terms,
                                 :attributes,
                                 :modifiers,
                                 :email,
                                 :password,
                                 :password_confirmation)
  end

end
