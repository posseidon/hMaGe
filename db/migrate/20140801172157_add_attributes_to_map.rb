class AddAttributesToMap < ActiveRecord::Migration
  def change
    # Type of map
    add_column :maps, :kind, :string
    # Meretarany of map
    add_column :maps, :size, :string
    # Felbontas of map
    add_column :maps, :resolutuon, :string
    # Kiado of map
    add_column :maps, :publisher, :string
  end
end
