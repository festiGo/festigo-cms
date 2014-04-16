class MakeFestigoOrganization < ActiveRecord::Migration
  def up
    #create a new organization
    o = Organization.find_or_create_by_name 'festiGo'
    users = User.joins('RIGHT JOIN roles on roles.user_id = users.id').readonly(false) #Only users with a role
    users.each do |user|
      user.organization = o
      user.save
    end
    RouteProfile.all.each do |profile|
      profile.organization = o
      profile.save
    end
    Route.all.each do |route|
      route.organization = o
      route.save
    end
  end

  def down
  end
end
