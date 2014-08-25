class AddExtendedAttrsToMap < ActiveRecord::Migration
  def change
    # Year of map
    add_column :maps, :year, :integer, :default => '1900'
    # Add Section (Szelveny szam)
    add_column :maps, :section, :string, :default => '0'
    # Add Theme to map
    add_column :maps, :theme, :string
    # Add projection system to map
    add_column :maps, :projection, :string, :default => 'EOV'
    # Add Grid exists (fokhalo)
    add_column :maps, :gridding, :boolean, :default => false
    # Add description
    add_column :maps, :description, :text
    # Add creator
    add_column :maps, :creator, :string
    # Add participante
    add_column :maps, :participante, :string
    # Add Language
    add_column :maps, :language, :string, :default => 'HU'
    # Add remarks
    add_column :maps, :remarks, :text
    # Add physical size
    add_column :maps, :physical_size, :integer, :default => 0
    # Add source
    add_column :maps, :source, :string, :default => 'ELTE TeGeTa'
  end
end
