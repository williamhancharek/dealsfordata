# Load the Rails application.
require_relative 'application'

# Initialize the Rails application.
Rails.application.initialize!
# ActionMailer::Base.smtp_settings = {
#   :user_name => ENV['SENDGRID_USERNAME'],
#   :password => ENV['SENDGRID_PASSWORD'],
#   :domain => 'dealsfordata.com',
#   :address => 'smtp.sendgrid.net',
#   :port => 587,
#   :authentication => :plain,
#   :enable_starttls_auto => true
# }
 #TODO I disabled this because I don't think I need to initialize this right away
