class RenameGroupIdToMapGroupId < ActiveRecord::Migration
  def up
  	rename_column :maps, :group_id, :map_group_id
  	remove_index :maps, :group_id
  	add_index  :maps, :map_group_id
  end

  def down
    rename_column :maps, :map_group_id, :group_id
    add_index :maps, :group_id
    remove_index  :maps, :map_group_id
  end
end
