class AddRegistrationNumberToMaps < ActiveRecord::Migration
  def change
    add_column :maps, :registartion_number, :string
  end
end
