class MapsController < ApplicationController
  def show
    @map = Map.find(params[:id])
    @polygons = @map.wkt_polygons.to_json
  end

  def edit
    @map = Map.find(params[:id])
  end

  def location
    @map = Map.find(params[:id])
    @polygons = @map.wkt_polygons.to_json
  end

  def set_grids
    @map = Map.find(params[:id])
    @map.grids.destroy_all
    factory = RGeo::Cartesian.factory

    params[:grids].each do |grid, value|
      unless value.empty?
        polygon = factory.parse_wkt(value)
        @map.grids.create(:grid_id => grid, :bbox => polygon)
      end
    end
    redirect_to map_path
  end

  def update
    @map = Map.find(params[:id])
    @map.update_attributes!(params[:map])
    redirect_to map_path
  rescue Exception => e
    flash[:notice] = "There was a problem updating map: #{e.message}."
    render :action => :edit
  end

  def search
    @maps = Map.search_by_attributes(params[:q])
  end

  def related
    @grids = Grid.st_relate(params[:geometry])
  end
end
