class NamesController < ApplicationController
  def list
    @names = Name.order("current").page(params[:page])
  end

  def search
    @names = Name.search_by_names(params[:q]).page(params[:page])
  end
end
