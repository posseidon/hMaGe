class MapsController < ApplicationController
  def index
    @maps = Map.all
  end
  def new
    @map = Map.find(1)
  end
end
