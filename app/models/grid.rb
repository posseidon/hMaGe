class Grid < ActiveRecord::Base
  attr_accessible :grid_id, :bbox

  belongs_to :map

  def Grid.st_relate(geometry)
    Grid.select("map_id").where("ST_Intersects(ST_GeomFromEWKT('SRID=4326;#{geometry}'), bbox)").group("map_id")
  end

  def Grid.st_overlap(geometry)
    Grid.select("map_id").where("ST_Intersects(ST_Envelope(ST_GeomFromEWKT('SRID=4326;#{geometry}')), bbox)").group("map_id")
  end
end
