class Offer < ApplicationRecord
  belongs_to :customer, class_name: "User"
  belongs_to :merchant, class_name: "User"
  has_one_attached :image


  def update(offer_params)
    super
    self.selected_option.nil? ? self.status = true : self.status = false
    self.save
  end

  def merchant_name
    self.merchant.name
  end





end
