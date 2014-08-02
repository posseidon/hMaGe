class Map < ActiveRecord::Base
  attr_accessible :name, :path, :image, :kind, :size, :resolutuon, :publisher

  # PostgreSQL full-text search
  include PgSearch
  pg_search_scope :search_by_attributes,
                  :against => [:name, :kind, :size, :resolutuon, :publisher],
                  :using => {
                    :tsearch => {:prefix => true}
                  }

  # Paperclip configuration
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
  def Map.processed(page)
    self.where(processed: true).page(page).per(AppConstants.maps_per_page)
  end

  #
  # Get all unprocessed images.
  #
  def Map.unprocessed(page)
    self.where(processed: false).page(page).per(AppConstants.maps_per_page)
  end
end
