class Box < ApplicationRecord
  belongs_to :user #TODO do I need to add dependent, destroy?
  has_many :offers
  geocoded_by :address

  enum public: [:false, :true]


  def address
    [street, city, state, country].compact.join(', ')
  end

  def active_offers
    self.offers.where("status = true")
  end

  def old_offers
    self.offers.where("status = false")
  end

end
