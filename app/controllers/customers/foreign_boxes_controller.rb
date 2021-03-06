class Customers::ForeignBoxesController < ApplicationController
  load_and_authorize_resource :class => "Box"
  skip_authorize_resource :only => :show
  skip_before_action :authenticate_user!, :only => :show

  before_action only: [:index] do
    ensure_box_owner(box_id: params[:box_id])
  end

  before_action only: [:index] do
    set_instance(instance:'box',id:params[:box_id],object: :Box)
  end

  def index
    @foreign_boxes = Box.where("user_id != ? and public = ?", @box.user_id,1)
  end

  def show
    @box = Box.find(params[:id])
    @old_offers = @box.old_offers
    @active_offers =@box.active_offers

  end

end
