class Plaid::AccessTokenController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    exchange_token_response =
      Client.item.public_token.exchange(params['public_token'])
    access_token = exchange_token_response['access_token']
    debugger
    @item = current_user.items.build(plaid_item_id: exchange_token_response['item_id'],
                            access_token: exchange_token_response['access_token'])
    respond_to do |format|
      if @item.save
        format.html {JSON.pretty_generate(exchange_token_response)}
        format.json {exchange_token_response.to_json}
      else
        format.html {render :new, flash: { warning: "failed to link card"}}
        format.json {render json: @item.errors, status: :unprocessable_entity}
      end

    end
  end
end
