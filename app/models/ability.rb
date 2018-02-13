class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user
      can [:create, :destroy, :update, :upvote, :downvote], [Post, Comment], user_id: user.id
    end
    if user && user.admin
      can :manage, :all
    end
  end
end
