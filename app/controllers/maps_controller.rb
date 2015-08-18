class MapsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :related, :overlap, :search]

  def show
    @map = Map.find(params[:id])
    @grids = (params[:grids].nil?) ? [].to_json : params[:grids]
    @polygons = @map.wkt_polygons.to_json
    @active_download_tickets = Ticket.can_user_request_download_ticket(current_user.id, params[:id])
    @mapgroup = MapGroup.find(@map.id)
  end

  def edit
    @map = Map.find(params[:id])

    authorize! :edit, @map
  end

  def location
    @map = Map.find(params[:id])
    @polygons = @map.wkt_polygons.to_json

    authorize! :location, @map
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

    authorize! :set_grids, @map
    redirect_to map_path
  rescue Exception => e
    flash[:notice] = "There was a problem Settings Grids on map: #{e.message}."
    render :action => :location
  end

  def update
    @map = Map.find(params[:id])
    @map.update_attributes!(params[:map])

    authorize! :update, @map
    redirect_to map_path
  rescue Exception => e
    flash[:notice] = "There was a problem updating map: #{e.message}."
    render :action => :edit
  end

  def search
    if params[:q].eql?("all")
      @maps = Map.all
    else
      session[:query] = params[:q]
      @maps = Map.search_by_attributes(params[:q])
    end
  end

  def related
    @grids = Grid.st_relate(params[:geometry])
    @maps = []
    @grids.each_key do |key|
      @maps << Map.find(key)
    end
  end

  def overlap
    if params[:points_geometry]
      @geometry = params[:points_geometry]
    else
      @geometry = params[:point_geometry]
    end
    @grids = Grid.st_overlap(@geometry)
    @maps = []
    @grids.each_key do |key|
      @maps << Map.find(key)
    end
  end
end
