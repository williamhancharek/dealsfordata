class Box < ApplicationRecord
  belongs_to :user #TODO do I need to add dependent, destroy?
  has_many :offers
end
