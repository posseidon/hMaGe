class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new(:role => 'guest')

    can :manage, User if user.role == 'admin'
    can :manage, Map  if user.role == 'editor'
    can :read,   Map  if user.role == 'viewer'
  end
end
