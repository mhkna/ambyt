class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, :all
    if user
      can [:upvote, :downvote], Post
      can [:create, :destroy, :update], [Post, Comment], user_id: user.id
    end
    if user && user.admin
      can :manage, :all
    end
  end
end
