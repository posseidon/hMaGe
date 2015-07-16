class AddMapGroupIdToMap < ActiveRecord::Migration
  def change
    add_column :maps, :group_id, :integer
    add_index  :maps, :group_id
  end
end
