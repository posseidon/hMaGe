class CreateMapGroups < ActiveRecord::Migration
  def change
    create_table :map_groups do |t|
      t.integer      :identifier, null: false, :unique => true
      t.string       :name, null: false
      t.timestamps
    end
  end
end
