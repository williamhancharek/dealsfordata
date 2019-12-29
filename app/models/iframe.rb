class Iframe
  include HTTParty
  KEY = ENV['IFRAMELY']
  base_uri 'www.iframely.com'
end
