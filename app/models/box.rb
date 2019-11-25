class Box < ApplicationRecord
  belongs_to :user #TODO do I need to add dependent, destroy?
  has_many :offers
  geocoded_by :address

  has_many :subscriber_relationships, foreign_key: :subscribing_id, class_name: 'Subscription'
  has_many :subscribers, through: :subscriber_relationships, source: :subscriber
  #subscriber means the number of other boxes following the box - aka how many
  #followers

  has_many :subscribing_relationships, foreign_key: :subscriber_id, class_name: 'Subscription'
  has_many :subscribing, through: :subscribing_relationships, source: :subscribing
  #subscribing means the number of boxes the box is following

  enum public: [:false, :true]


  def address

    if street.to_s.length == 0 && city.to_s.length == 0 && state.to_s.length == 0 && country.to_s.length == 0
      return "unstated"
    else
      [street, city, state, country].compact.join(', ')
    end
  end

  def active_offers
    self.offers.where("status = true")
  end

  def old_offers
    self.offers.where("status = false")
  end

  def subscribe(box_id)
    subscribing_relationships.create(subscribing_id: box_id)
  end

  def unsubscribe(box_id)
    subscribing_relationships.find_by(subscribing_id: box_id).destroy
  end

  def subscribed?(box_id)
    #checks if the box is subscribed to the other box identified by box_id
    Subscription.exists?(subscribing_id: box_id, subscriber_id: self.id)
  end

end
