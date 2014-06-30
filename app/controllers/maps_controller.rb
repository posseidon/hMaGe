class MapsController < ApplicationController
  def index
    @maps = Map.unprocessed(params[:page])
  end

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
    flash[:notice] = "There was a problem creating issue #{@issue.subject}: #{e.message}."
    render :action => :edit
  end

  def new
    @map = Map.find(1)
  end
end
