class AddRequestTypeToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :request_type, :string, :null => false, :default => 'DOWNLOAD'
  end
end
