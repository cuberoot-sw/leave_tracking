class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here.
    if user.role? :admin
      can :manage, :all
    end
    if user.role? :employee
      can :manage, User
    end
  end
end
