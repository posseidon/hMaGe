class MapsController < ApplicationController
  def new
    @map = Map.find(1)
  end
end
