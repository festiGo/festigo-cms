class RemoveOrganizationFromRoute < ActiveRecord::Migration
  def change
    remove_column :routes, :organization_id
  end
end
