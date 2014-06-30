class Map < ActiveRecord::Base
  attr_accessible :name, :path, :image
  has_attached_file :image,
    :styles => {
      :thumb  => '100x100>',
      :medium => '500x375>',
      :large   => '1000x1000>',
    },
    :default_url => "/missing.png",
    :url => "/system/:style/:filename.:extension"

  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  #
  # Get all Processed images
  #
  def Map.processed
    self.where(processed: true)
  end

  #
  # Get all unprocessed images.
  #
  def Map.unprocessed
    self.where(processed: false)
  end
end
