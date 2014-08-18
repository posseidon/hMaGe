class NamesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :find, :search]
  load_and_authorize_resource

  def list
    @names = Name.order("current").page(params[:page])
  end

  def search
    @names = Name.search_by_attributes(params[:q])
  end

  def find
    @names = Name.search_by_name(params[:q])
    respond_to do |format|
      format.html
      format.json { render :json => @names }
    end
  end

  def new
    @name = Name.new
  end

  def create
    @name = Name.new(params[:name])
    @name.save!
    redirect_to name_path(@name), :notice => "SAVE NAME OK."
  rescue Exception => ex
    render action: "new"
  end

  def show
    @name = Name.find(params[:id])
  end

  def edit
    @name = Name.find(params[:id])
  end

  def update
    @name = Name.find(params[:id])
    if @name.update_attributes!(params[:name])
      redirect_to name_path(@name), :notice => "SAVE NAME OK."
    else
      render edit_name_path
    end
  rescue Exception => ex
    render action: "edit"
  end

end
