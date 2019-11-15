class Offer < ApplicationRecord
  belongs_to :box
  belongs_to :campaign
  has_one_attached :image


  def update(offer_params)
    super
    self.selected_option.nil? ? self.status = true : self.status = false
    self.save
  end

  def merchant_name
    self.campaign.user.name
  end





end
