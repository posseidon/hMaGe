class Map < ActiveRecord::Base
  attr_accessible :name, :path, :image, :kind, :size, :resolution, :publisher,
                  :downloadable, :processed, :year, :section, :theme, :projection, :description,
                  :creator, :participante, :language, :remarks, :source, :gridding, :physical_size

  belongs_to :map_groups
  has_many :grids, dependent: :destroy
  has_many :tickets
  paginates_per 10

  # PostgreSQL full-text search
  include PgSearch
  pg_search_scope :search_by_attributes,
                  :against => [:name, :kind, :size, :resolution, :publisher,
                               :year, :section, :theme, :projection, :description,
                               :creator, :participante, :language, :remarks, :source],
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
    :path => "/var/data/hmage/system/:style/:filename.:extension",
    :url  => "/system/:style/:filename.:extension"

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

  def wkt_polygons
    polygons = []
    self.grids.each do |grid|
      polygons << {name: grid.grid_id, bbox: grid.bbox.as_text}
    end
    return polygons
  end
end
