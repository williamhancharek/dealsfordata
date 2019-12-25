class Merchants::OffersController < ApplicationController
  load_and_authorize_resource

  def index

  end

  def show

  end
  #TODO: should merchants be able to edit their offer?
  #merchants can't edit offers just yet because only
  #employees do that for them at this point.  if they
  #can edit, in what way?


end
