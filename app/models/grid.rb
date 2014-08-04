class Grid < ActiveRecord::Base
  attr_accessible :grid_id, :bbox

  belongs_to :map

  def Grid.st_relate(geometry)
    Grid.where("ST_Intersects(ST_GeomFromText('SRID=4326;#{geometry}'), bbox)")
  end
end
