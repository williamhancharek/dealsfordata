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
    unless image_url == nil
      image_url.prepend("https:") if image_url.start_with?("//")
      begin
        downloaded_image = open(image_url)
        self.image.attach(io: downloaded_image  , filename: "image.jpg")
      rescue
        puts "image url was probably malformed or did not exist"
      end
    end
  end

  def setup_iframe(link)
    response = Iframe.new(link)
    binding.pry_remote
    if response.valid? #TODO this is shitty error handling
      self.description = response.description
      self.html = response.html
      self.grab_image(response.thumbnail_url)
      self.current_price = response.price
      self.tags << response.category
    end
  end

  def rotate_selection
    index = self.options.index(self.selected_option)
    count = self.options.count - 1
    if index < count
      index += 1
      index += 1 if self.options[index] == "spam"

    else
      index = 0
      index += 1 if self.options[index] == "spam"
    end
    self.selected_option = self.options[index]
    #TODO I don't want the user, at the archived page, to be able to select spam - it should have already been weeded out.  That being said, I don't want to necessarily destroy offers labelled as spam, because I need that data for training.  They have the opportunity to label as spam at the get-go, but afterwards, it has passed their "spam" filter.  Honestly, I don't know if "spam" as a category works since it's just a HARD dislike
  end

end
