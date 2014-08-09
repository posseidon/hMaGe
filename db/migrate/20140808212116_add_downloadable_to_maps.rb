class AddDownloadableToMaps < ActiveRecord::Migration
  def change
    add_column :maps, :downloadable, :boolean, :default => 'true'
  end
end
