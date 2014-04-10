class RenameIconInOrganization < ActiveRecord::Migration
  def up
    rename_column :organizations, :icon, :image
  end

  def down
    rename_column :organizations, :image, :icon
  end
end
