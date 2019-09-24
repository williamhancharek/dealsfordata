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

        format.html {redirect_to(customer_path(current_user))}
        #TODO if I don't redirect_to, then turbolinks prevents a full refresh, which
        #causes the "linked cards number to not increase.  I would like to just refresh"
        #the user object and leave everything else the same... but not sure how
        format.json {exchange_token_response.to_json}
      else

        format.html {render :new, flash: { warning: "failed to link card"}}
        format.json {render json: @item.errors, status: :unprocessable_entity}
      end

    end
  end
end
