class Offer < ApplicationRecord
  belongs_to :box
  belongs_to :campaign
  has_one_attached :image
  validates :description, presence: true
  validates :title, presence: true
  validates :options, presence: true
  validates :description, presence: true
  validate :old_offers_must_have_selection
  store_accessor :status, :email_sent, :active, :type #TODO I haven't used type yet

  #type is video, purchase, or blog
  #email_sent is true, or false
  #active is true, or false

  def update(offer_params)
    super
    handle_public_selected_option(offer_params)
    binding.pry_remote

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

end
