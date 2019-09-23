class Account < ApplicationRecord
  belongs_to :account
  has_many :transactions
end
