class CreateMaps < ActiveRecord::Migration
  def change
    create_table :maps do |t|
      t.string :name, null: false, default: 'Unprocessed Map'
      t.string :path, null: false

      t.timestamps
    end
  end
end
