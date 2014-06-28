class AddAttachmentImageToMaps < ActiveRecord::Migration
  def self.up
    change_table :maps do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :maps, :image
  end
end
