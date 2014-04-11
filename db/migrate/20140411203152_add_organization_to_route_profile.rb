class AddOrganizationToRouteProfile < ActiveRecord::Migration
  def change
    add_column :route_profiles, :organization_id, :integer
  end
end
