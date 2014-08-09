class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/404.html", :status => 403, :layout => false
  end

  private
  def after_sign_in_path_for(resource_or_scope)
    root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    about_path
  end
end
