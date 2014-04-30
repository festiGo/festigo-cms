  class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    user ||= User.new # guest user (not logged in)
    if user.role? :global_admin
      can :manage, :all
      can :admin
    elsif user.roles.count > 0
      can :manage, City
      cannot [:create, :update, :destroy], City do |city|
        !user.role? :curator, city
      end
      can [:read, :new, :search, :in_cities], RouteProfile
      can [:create], RouteProfile do |profile|
        user.role? :curator, profile.city
      end
      can [:update, :destroy, :crop], RouteProfile do |profile|
        user.organization == profile.organization
      end
      can [:read, :new, :search, :waypoints], Route
      can [:create, :update, :destroy, :crop, :publish, :unpublish], Route do |route|
        user.role? :curator, route.city && user.organization == route.route_profile.organization
      end
      can [:read, :new, :search], Location
      can [:create], Location do |location|
        user.role? :curator, location.network
      end
      can [:update, :destroy, :crop], Location do |location|
        user.role? :curator, location.network # && user.organization == location.organization
      end
      #can :manage, Reward

      can [:new,:create, :update, :destroy], Reward do |reward|
        user.role? :curator, reward.route.city && user.organization == reward.route.route_profile.organization
      end

    else
      #Just a regular player
      can :read, Location
    end
    cannot [:create, :update, :destroy], Checkin
    can :read, Reward
    can :read, Route
  end
end
