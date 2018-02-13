class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.admin_role?
      can :manage, :all
    end
    if user.user_role?
    end
  end
end
