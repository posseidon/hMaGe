class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.text       :uid, :unique => true
      t.integer    :user_id
      t.integer    :map_id
      t.string     :status
      t.timestamps
    end

    add_index :tickets, [:uid]
  end
end
