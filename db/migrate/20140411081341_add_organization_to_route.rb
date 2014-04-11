class AddOrganizationToRoute < ActiveRecord::Migration
  def change
    add_column :routes, :organization_id, :integer
  end
end
