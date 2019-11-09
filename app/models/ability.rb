# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    user ||= User.new # guest user (not logged in)

    if user.admin?
      can :manage, :all
    end

    if user.employee?
      can :manage, Offer
      can :manage, User
    end #this is bad because I only want employees to be able to create new merchants, which are users
         #but this allows them to create anything... but whatever let's move on
    if user.merchant?
      can :read, Offer, id: offer.merchant_id
    end

    if user.customer?
      can :update, User, id: user.id
      can :update, Offer, id: offer.customer_id
    end
       #   #TODO there is an issue here - I want the user to be able to update the
       #   #offer's selection, but they should not be able to update the offer's contents - they can't re-write the description
       #   #so this means selectively only allowing updating certain properties of the object... otherwise I have to split the
       #   #object in two - this is for another day... when we get more real
  end
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
end
