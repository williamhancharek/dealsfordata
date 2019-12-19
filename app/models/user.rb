class User < ApplicationRecord
  validates :email, presence: true
  has_one_attached :identicon
  store_accessor :settings, :allow_email
  #TODO Before_save, check that a customer doesn't have offers, and check that a
  #merchant doesn't have boxes?
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :confirmable, :timeoutable
  has_many :boxes, dependent: :destroy
  has_many :campaigns, dependent: :destroy

  has_many :assignments
  has_many :assigned_boxes, through: :assignments, source: 'box'

  enum role: [:customer, :merchant, :employee, :admin, :moderator]
  # validates_inclusion_of :keywords, :in => %r(a-zA-z)



#CUSTOMER METHODS


  def update_keywords(keywords)
    self.keywords_will_change!
    self.keywords = keywords.split(" ")
  end

#MERCHANT METHODS


#EMPLOYEE METHODS
  # def list_boxes
  #   boxes = []
  #   if !(self.assigned_boxes.nil?)
  #     self.assigned_boxes.each do |t|
  #       boxes << find_box(t).id
  #     end
  #   end
  #   return boxes
  # end

  # def find_box(t)
  #   Box.find(t)
  # end
  #
  # def remove_box(t)
  #   self.assigned_boxes.delete(t)
  # end
  #
  # def add_boxes(t)
  #   self.assigned_boxes ||= []
  #   if t.match(/[0-9]/)
  #     self.assigned_boxes.push(t)
  #   end
  # end

  def assigned?(id)
    #TODO this function should return true or false whether a customer is assigned to this employee
  end

  def assigned_customers
    self.assigned_boxes.map {|t| t.user}
  end

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
