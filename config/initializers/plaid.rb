require 'plaid'
client = Plaid::Client.new(env: ENV['PLAID_ENV'],
                           client_id: ENV['PLAID_CLIENT_ID'],
                           secret: ENV['PLAID_SECRET'],
                           public_key: ENV['PLAID_PUBLIC_KEY'])

builder.options[:timeout] = 60*20
#TODO is this bad?  to make ::Client a global constant...?
