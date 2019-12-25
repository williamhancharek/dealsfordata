class Employees::CampaignsController < ApplicationController
  load_and_authorize_resource
  before_action {ensure_role("admin","employee", "moderator")}

  before_action only: [:index, :new, :create] do
    set_instance(instance:'merchant',
                        id:params[:user_id],
                    object: :User)
  end

  def index
    @campaigns = @merchant.campaigns
  end

  def new
    @campaign = @merchant.campaigns.build
  end

  def create
    @campaign = @merchant.campaigns.build(campaign_params)
    respond_to do |format|
      if @campaign.save
        format.html {redirect_back fallback_location: :new, notice: "campaign was successfully created"}
        format.json {render :new, status: :create, location: @user}
      else
        format.html {render :new}
        format.json {render json: @campaign.errors, status: :unprocessable_entity}
      end
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(:name)
  end


end
