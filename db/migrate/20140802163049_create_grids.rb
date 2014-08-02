class CreateGrids < ActiveRecord::Migration
  def change
    create_table :grids do |t|
      t.references :map
      t.string     :grid_id
      t.polygon    :bbox, :srid => 4326
    end
  end
end
