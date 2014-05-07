class AddDateStartDateEndToRouteProfile < ActiveRecord::Migration
  def change
    add_column :route_profiles, :date_start, :date
    add_column :route_profiles, :date_end, :date
  end
end
