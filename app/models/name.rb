class Name < ActiveRecord::Base
  attr_accessible :current, :original, :description, :latlon
  validates_uniqueness_of :original
  validates :current, :original, :latlon, presence: true

  paginates_per 15

  # PostgreSQL full-text search
  include PgSearch
  pg_search_scope :search_by_names,
                  :against => [:original, :current, :description],
                  :using => {
                    :tsearch => {:prefix => true}
                  }
end
