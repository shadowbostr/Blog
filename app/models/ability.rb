# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)

    if user.present?
    can :read, :all # Allow all users to read (view) everything
    end
    can [:update, :destroy], Post, user: user
    can :update, Comment, user: user


  end
end
