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

#CUSTOMER METHODS
  def get_offers #I can probably make this a one-liner using some kind of build the method as I go thing... but fuck it
    case self.role
    when 'customer'
      self.customer_offers.where("status = true")
    when 'merchant'
      self.merchant_offers.where("status = true")
    end
  end

  def get_old_offers
    case self.role
    when 'customer'
      self.customer_offers.where("status = false")
    when 'merchant'
      self.merchant_offers.where("status = false")
    end
  end


  def update_keywords(keywords)
    self.keywords_will_change!
    self.keywords = keywords.split(" ")
  end

#MERCHANT METHODS

#EMPLOYEE METHODS


#ADMIN METHODS
  def attach_identicon
    RubyIdenticon.create_and_save("#{self.email}",
                                  "tmp/identicon_#{self.email}.png",
                                  square_size: 20)
    data = open("tmp/identicon_#{self.email}.png")
    self.identicon.attach(io:data,
                          filename:"tmp/identicon_#{self.email}.png")
  end

#TODO set up omniauthable
#TODO I think I should remove tags from the user database.  I think I added it in accidentally.
#TODO modifiers are not supposed to be able to be modified by user - can only be modified by administtrator to associate Profile
#with modifiers like "rich" or "eats lots of sushi"
end
