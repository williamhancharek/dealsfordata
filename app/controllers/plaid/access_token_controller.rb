class Plaid::AccessTokenController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    debugger
  end
end
