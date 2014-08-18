class Name < ActiveRecord::Base
  attr_accessible :current, :original, :description, :latlon
  validates :original, :uniqueness => true
  validates :current, :original, :latlon, presence: true, :on => :create

  paginates_per 15

  # PostgreSQL full-text search
  include PgSearch
  pg_search_scope :search_by_attributes,
                  :against => [:original, :current, :description],
                  :using => {
                    :tsearch => {:prefix => true}
                  }

  pg_search_scope :search_by_name,
                  :against => [:original, :current],
                  :using => {
                    :tsearch => {:prefix => true}
                  }

  def latlon
    factory = RGeo::Cartesian.factory
    coordinates = read_attribute(:latlon)
    coordinates ||= factory.parse_wkt("POINT(0 0)")
  end

end
