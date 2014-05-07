class AddOrganizationToLocation < ActiveRecord::Migration
  def up
    add_column :locations, :organization_id, :integer
    Location.all.each do |location|
      location.organization_id = 1
    end
  end

  def down
    remove_column :locations, :organization_id
  end
end
