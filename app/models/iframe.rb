class Iframe
  include HTTParty
  base_uri 'https://iframe.ly'

  default_params api_key: ENV['IFRAMELY_API']

  def initialize(url)
    @options = {query: {url: url}}
  end

  def oembed
    self.class.get("/api/oembed", @options)
  end

  def iframely
    self.class.get("/api/iframely", @options)
  end

  def description
    self.oembed["description"]
  end

  def title
    self.title["description"]
  end

  def provider_name
    self.oembed["provider_name"]
  end

  def description
    self.oembed["description"]
  end

  def thumbnail_url
    self.oembed["thumbnail_url"]
  end

  def html
    self.oembed["html"]
  end

  def code
    self.oembed.code
  end

end
