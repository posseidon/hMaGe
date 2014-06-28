class AddProcessedToMaps < ActiveRecord::Migration
  def change
    add_column :maps, :processed, :boolean, default: false
  end
end
