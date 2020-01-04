class Offer < ApplicationRecord
  belongs_to :box
  belongs_to :campaign
  has_one_attached :image
  validates :options, presence: true
  validate :old_offers_must_have_selection
  store_accessor :status, :email_sent, :active, :type #TODO I haven't used type yet

  #type should be video?, purchase, or blog post or should it just be purchase and info
  #email_sent is true, or false
  #active is true, or false

  def update(offer_params)
    super
    handle_public_selected_option(offer_params)

    self.selected_option.nil? ? self.active = true : self.active = false
    self.save
  end

  def merchant_name
    self.campaign.user.name
  end

  def old_offers_must_have_selection
    if self.status == false && (self.selected_option == nil || self.selected_option == "")
      errors.add(:base, "must select an option")
    end
  end

  def handle_public_selected_option(offer_params)
    if offer_params["public_selected_option"].nil?
    elsif !(offer_params["public_selected_option"].reject(&:blank?).blank?)
      self.public_selected_option= offer_params["public_selected_option"].reject(&:blank?)[0]
    end
  end

  def grab_image(image_url)
    image_url.prepend("https:") if image_url.start_with?("//")
    begin
      downloaded_image = open(image_url)
      self.image.attach(io: downloaded_image  , filename: "image.jpg")
    rescue
      puts "image url was probably malformed"
    end
  end

  def setup_iframe(link)
    response = Iframe.new(link)
    if response.code == 200 #TODO this is shitty error handling
      self.description = response.description
      self.html = response.html
      self.grab_image(response.thumbnail_url)
    end
  end

end
