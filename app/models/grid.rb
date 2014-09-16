class Grid < ActiveRecord::Base
  attr_accessible :grid_id, :bbox

  belongs_to :map

  def Grid.st_relate(geometry)
    grids = Grid.select("map_id, grid_id").where("ST_Intersects(ST_GeomFromEWKT('SRID=4326;#{geometry}'), bbox)")
    collectMapGrids(grids)
  end

  def Grid.st_overlap(geometry)
    grids = Grid.select("map_id, grid_id").where("ST_Intersects(ST_Envelope(ST_GeomFromEWKT('SRID=4326;#{geometry}')), bbox)")
    collectMapGrids(grids)
  end

  private
  def self.collectMapGrids(map_grids)
    result = {}

    map_grids.each do |grid|
      result[grid.map_id] ||= []
      result[grid.map_id] << grid.grid_id
    end

    result
  end
end
