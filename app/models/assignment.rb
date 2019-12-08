class Assignment < ApplicationRecord
  validates :user_id, presence: true
  validates :box_id, presence: true
  belongs_to :user
  belongs_to :box
end
