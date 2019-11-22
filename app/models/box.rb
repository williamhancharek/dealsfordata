class Box < ApplicationRecord
  belongs_to :user #TODO do I need to add dependent, destroy?
  has_many :offers
  geocoded_by :address

  has_many :subscriber_relationships, foreign_key: :subscribing_id, class_name: 'Subscription'
  has_many :subscribers, through: :subscriber_relationships, source: :subscriber
  #subscriber means the number of other boxes following the box

  has_many :subscribing_relationships, foreign_key: :subscriber_id, class_name: 'Subscription'
  has_many :subscribing, through: :subscribing_relationships, source: :subscribing
  #subscribing means the number of boxes the box is following

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

  def subscribe(box_id)
    subscribing_relationships.create(subscribing_id: box_id)
  end

  def unsubscribe(box_id)
    subscribing_relationships.find_by(subscribing_id: box_id).destroy
  end

end
