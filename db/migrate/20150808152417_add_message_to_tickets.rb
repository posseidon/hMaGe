class AddMessageToTickets < ActiveRecord::Migration
  def change
  	add_column :tickets, :message, :text
  end
end
