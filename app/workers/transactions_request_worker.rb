class TransactionsRequestWorker
  include Sidekiq::Worker

  def perform(days:, access_token:, user_id:)
    user = User.find(user_id) #TODO what did I need this user for?
    now = Date.today
    thirty_days_ago = (now - days)
    begin
      product_response = Client.transactions.get(access_token, thirty_days_ago, now)
      product_response.transactions.each do |t|
        Transaction.create()
      end
    rescue Plaid::PlaidAPIError => e
      error_response = format_error(e)
      JSON.pretty_generate(error_response)
      content_type :json
      error_response.to_json  #TODO  need to remake this in the context of just pulling data
    end
  end

end
