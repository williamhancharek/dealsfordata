class Iframe
  include HTTParty
  base_uri 'https://iframe.ly'

  default_params api_key: ENV['IFRAMELY_API']

  def initialize(url, **splat) #TODO iframely says I should URL-encode these urls... am I doing that?
    @options = {query: {url: url}}
    @options[:query] = @options[:query].merge(splat)
  end

  def valid?
    status = self.oembed["status"]

    if status.present? && status.between?(399,500)
      return false
    else
      return true
    end
  end

  def oembed_small
    @options[:query]["&iframe"]="card-small"
    self.class.get("/api/oembed", @options)
  end

  def oembed
    self.class.get("/api/oembed", @options)
  end

  def iframely
    self.class.get("/api/iframely", @options)
  end

  def price
    if self.iframely["meta"]["price"].present?
      self.iframely["meta"]["price"]
    else
      nil
    end
  end

  def category
    if self.iframely["meta"]["category"].present?
      self.iframely["meta"]["category"]
    else
      nil
    end
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
    if self.oembed["thumbnail_url"].present?
      self.oembed["thumbnail_url"]
    else
      self.iframely.dig('links', 'icon',0,"href")
    end
  end

  def html
    self.oembed["html"]
  end

  def html_small
    self.oembed_small["html"]
  end

  def code
    self.oembed.code
  end

end
