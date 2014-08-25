class RenameResolutuonToResolution < ActiveRecord::Migration
  def change
    rename_column :maps, :resolutuon, :resolution
  end
end
