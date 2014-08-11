class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from ActiveRecord::RecordNotFound,   :with => :rescue_not_found


  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/401.html", :status => 401, :layout => false
  end

  #
  # Added routing in 'routes.rb'
  #
  def raise_not_found!
    render :file => "#{Rails.root}/public/405.html", :status => 405, :layout => false
  end

  protected

  def rescue_not_found
    render :file => "#{Rails.root}/public/404.html", :status => 404, :layout => false
  end

  private
  def after_sign_in_path_for(resource_or_scope)
    root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    about_path
  end
end
