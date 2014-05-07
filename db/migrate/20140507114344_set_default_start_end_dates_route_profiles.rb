class SetDefaultStartEndDatesRouteProfiles < ActiveRecord::Migration
  def up
    RouteProfile.all.each do |routeprofile|
      routeprofile.date_start = Date.today
      routeprofile.date_end = (Date.today + 365)
      routeprofile.save
    end
  end

  def down
  end
end
