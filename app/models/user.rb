class User < ApplicationRecord
  has_one_attached :identicon
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :offers
  has_many :items
  enum role: [:customer, :merchant, :employee, :admin]

  def get_offers
    self.offers.where("status = true")
  end

#TODO set up omniauthable

end
