class Campaign < ApplicationRecord
  belongs_to :user, dependent: :destroy
  has_many :offers
  validates :name, presence: true
end
