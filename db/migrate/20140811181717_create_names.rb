class CreateNames < ActiveRecord::Migration
  def change
    create_table :names do |t|
      t.string     :original, :unique => true
      t.string     :current
      t.text       :description
      t.point      :latlon, :srid => 4326
    end
  end
end
