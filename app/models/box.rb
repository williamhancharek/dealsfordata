class Box < ApplicationRecord
  belongs_to :user #TODO do I need to add dependent, destroy?
  has_many :offers, dependent: :destroy
  geocoded_by :address
  validates :name, presence: true
  validates :search_terms, presence: true
  store_accessor :settings, :allow_email, :background
  validates :min_price, :max_price, numericality: {only_integer: true, allow_nil: true}

  has_many :assignments
  has_many :employees, through: :assignments, source: 'user'

  has_many :subscriber_relationships, foreign_key: :subscribing_id, class_name: 'Subscription'
  has_many :subscribers, through: :subscriber_relationships, source: :subscriber
  #subscriber means the number of other boxes following the box - aka how many
  #followers

  has_many :subscribing_relationships, foreign_key: :subscriber_id, class_name: 'Subscription'
  has_many :subscribing, through: :subscribing_relationships, source: :subscribing
  #subscribing means the number of boxes the box is following

  enum public: [:false, :true] #0 = false, which is private, 1 is true, which is public


  def address #TODO - this is ugly and can honestly be improved... but no time to think it thru
    if [street, city, state, country].reject(&:blank?).empty?
      return "unstated"
    else
      [street, city, state, country].reject(&:empty?).join(', ')
    end
  end

  def active_offers #TODO pick up from here
    self.offers.where("status ->>'active' = 'true'")
  end

  def old_offers
    self.offers.where("status ->>'active' = 'false'")
  end

  def unapproved_offers
    self.offers.where("approved = false")
  end

  def approved_offers
    self.offers.where("approved = true")
  end

  def approved_active_offers
    self.offers.where("approved = true and status ->> 'active' = 'true'")
  end

  def approved_active_offer
    self.offers.where("approved = true and status ->> 'active' = 'true'").take
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

  def public?
    self.public == "true" ? true : false
  end

  def list_employee_ids
    self.employees.map {|t| t.id}
  end

  def price_range
    if self.min_price.present? && self.max_price.present?
      "$#{self.min_price} - $#{self.max_price}"
    elsif self.min_price.present?
      "$#{self.min_price}"
    elsif self.max_price.present?
      "$#{self.max_price}"
    else
      "no price range given"
    end
  end

end
