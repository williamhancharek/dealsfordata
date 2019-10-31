class User < ApplicationRecord
  has_one_attached :identicon
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :merchant_offers, class_name: "Offer", foreign_key: "merchant_id"
  has_many :customer_offers, class_name: "Offer", foreign_key: "customer_id"

  enum role: [:customer, :merchant, :employee, :admin]
  # validates_inclusion_of :keywords, :in => %r(a-zA-z)

  # def update(params)
  #   # case self.role
  #   # when "customer"
  #   #   # update_keywords(params[:keywords])
  #   # when "merchant"
  #   # when "employee"
  #   # when "admin"
  #   # end
  #   super
  #   binding.pry_remote
  # end
#Customer methods
  def get_offers
    self.offers.where("status = true")
  end

  def update_keywords(keywords)
    self.keywords_will_change!
    self.keywords = keywords.split(" ")
  end

#merchant Methods


#administrator methods?



#TODO set up omniauthable
#TODO I think I should remove tags from the user database.  I think I added it in accidentally.
#TODO modifiers are not supposed to be able to be modified by user - can only be modified by administtrator to associate Profile
#with modifiers like "rich" or "eats lots of sushi"

end
