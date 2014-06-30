class MapsController < ApplicationController
  def index
    @maps = Map.unprocessed(params[:page])
  end

  def new
    @map = Map.find(1)
  end
end
