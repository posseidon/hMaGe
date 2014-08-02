class MapsController < ApplicationController
  def show
    @map = Map.find(params[:id])
  end

  def edit
    @map = Map.find(params[:id])
  end

  def location
    @map = Map.find(params[:id])
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
end
