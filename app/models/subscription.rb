class Subscription < ApplicationRecord
  belongs_to :subscriber, foreign_key: 'subscriber_id', class_name: 'Box'
  belongs_to :subscribing, foreign_key: 'subscribing_id', class_name: 'Box'
end
