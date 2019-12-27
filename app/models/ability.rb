# frozen_string_literal: true

class Ability #TODO when this becomes bigger I should refactor into separate files
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:

    #NOTE show update edit destroy create index new

    user ||= User.new # guest user (not logged in)

    #The visitor should be able to see public boxes, and view those public boxes' offer history

    if user.customer?
      can :read, User, id: user.id
      can :read, User, role: "customer"
      # can :read, User, role: "customer"
      can :update, User, id: user.id
    #   #destroying user is thru devise and it seems that the permission is not needed here
    #
      can :create, Offer
      can :read, Offer, box: {user: {id:user.id}}
      can :update, Offer, box: {user: {id: user.id}}
    #
      can :create, Box #TODO is this the correct permission?
      can :manage, Box, user: {id:user.id}
      # can :index, Box, public: 1 #should I switch to hash?
      can :show, Box, public: 1
      can :index, Box, public: 1 #TODO I haven't tested this particular ability yet

      can :create, Subscription, subscriber: {user: {id: user.id}}, subscribing: {public: 1}
      can :destroy, Subscription, subscribing: {user: {id: user.id}}
      can :destroy, Subscription, subscriber: {user: {id: user.id}}
      can :index, Subscription, subscribing: {user: {id:user.id}}
    end

    if user.employee?
      can :manage, User, role: "customer"
      can :manage, User, role: "merchant"
      can [:show, :index, :update, :edit], User, id:user.id

      can [:show, :index, :edit, :update], Box
      can :manage, Offer
    end

    if user.moderator?
      can :manage, User, role: 'customer'
      can :manage, User, role: 'merchant'
      can :manage, User, role: 'employee'

      can :manage, Box
      can :manage, Offer
    end

    if user.merchant?
      can :read, User, id: user.id
      can :read, Offer, id: offer.merchant_id
    end

    if user.admin?
      can :manage, :all
    end
         #TODO there is an issue here - I want the user to be able to update the
         #offer's selection, but they should not be able to update the offer's contents - they can't re-write the description
         #so this means selectively only allowing updating certain properties of the object... otherwise I have to split the
         #object in two - this is for another day... when we get more real
  end

  private

  def user_abilities

  end

  def admin_abilities

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
