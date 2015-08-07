class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new(:role => 'guest')

    can :manage, User if user.role == 'admin'

    can :manage, Map  if user.role == 'editor'
    can :read,   Map  if user.role == 'viewer'

    can :manage, Name if user.role == 'editor'
    can :read,   Name if user.role == 'viewer' or user.role == 'guest'
    can :find,   Name if user.role != 'admin'
    can :search, Name if user.role != 'admin'

    can :manage, Ticket if user.role == 'librarian'
    can :create, Ticket if user.role == 'viewer' or user.role == 'editor'
    can :read,   Ticket if user.role == 'viewer' or user.role == 'editor'
  end
end
