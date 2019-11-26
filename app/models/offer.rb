class Offer < ApplicationRecord
  belongs_to :box
  belongs_to :campaign
  has_one_attached :image
  validates :description, presence: true
  validates :title, presence: true
  validates :options, presence: true
  validates :description, presence: true
  validate :old_offers_must_have_selection

  def update(offer_params)
    super
    self.selected_option.nil? ? self.status = true : self.status = false
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

end
