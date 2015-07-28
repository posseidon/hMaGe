class ChangeDataTypeForMaps < ActiveRecord::Migration
  def up
  	change_column :maps, :creator, :text
  	change_column :maps, :name, :text
  	change_column :maps, :participante, :text
  end

  def down
  	change_column :maps, :creator, :string
  	change_column :maps, :name, :string
  	change_column :maps, :participante, :string
  end
end
