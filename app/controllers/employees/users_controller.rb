class Employees::UsersController < ApplicationController
  before_action {ensure_role("admin","employee", "moderator")}

  # before_action only: [:show, :edit, :update, :destroy] do
  #   set_instance(instance:"user", id:params[:id],object: :User)
  # end

  def new
    @user = User.new

  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html {redirect_back fallback_location: :new, notice: "User was successfully created"}
        format.json {render :new, status: :create, location: @user} #I don't know what this means
      else
        format.html {render :new}
        format.json {render json: @campaign.errors, status: :unprocessable_entity}
      end
    end
  end

  def show
    @user = User.find(params[:id])

  end

  private

  def user_params
    params.require(:user).permit(:email,
                                  :password,
                                  :password_confirmation,
                                  :search_terms,
                                  :keywords,
                                  :modifiers,
                                  :role,
                                  :name)

  end

end
