class AddGformatToMaps < ActiveRecord::Migration
  def change
  	add_column :maps, :gformat, :string
  end
end
