class Webhooks::PlaidTransactionsController < ApplicationController

  def show
    #TODO pretty_generate probably fails
    now = Date.today
    thirty_days_ago = (now - 30)
    begin
      product_response = client.transactions.get(access_token, thirty_days_ago, now)
      pretty_print_response(product_response)
      content_type :json
      { transactions => product_response }.to_json
    rescue Plaid::PlaidAPIError => e
      error_response = format_error(e)
      JSON.pretty_generate(error_response)
      content_type :json
      error_response.to_json
    end
  end

end
