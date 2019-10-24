class Offer < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  def update(offer_params)
    super
    self.selected_option.nil? ? self.status = true : self.status = false
    self.save
  end

end
