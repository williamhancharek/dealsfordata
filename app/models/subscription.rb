class Subscription < ApplicationRecord
  validates :subscriber_id, presence: true
  validates :subscribing_id, presence: true

  belongs_to :subscriber, foreign_key: 'subscriber_id', class_name: 'Box'
  belongs_to :subscribing, foreign_key: 'subscribing_id', class_name: 'Box'
end
