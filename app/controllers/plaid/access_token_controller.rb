class Plaid::AccessTokenController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    exchange_token_response =
      Client.item.public_token.exchange(params['public_token'])
    access_token = exchange_token_response['access_token']
    @item = current_user.items.build(plaid_item_id: exchange_token_response['item_id'],
                            access_token: exchange_token_response['access_token'])
    respond_to do |format|
      if @item.save
        #format.js #OPTIMIZE - I want to use jquery to do a small database call so I don't have to do
        #a full refresh to get all the data regarding customer integrations
        format.html {redirect_to(customer_path(current_user))}
        format.json {exchange_token_response.to_json}
      else

        format.html {render :new, flash: { warning: "failed to link card"}}
        format.json {render json: @item.errors, status: :unprocessable_entity}
      end

    end
  end
end
