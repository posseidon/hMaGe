class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  rescue_from ActiveRecord::RecordNotFound,   :with => :rescue_not_found

  rescue_from CanCan::AccessDenied do |exception|
    render :file => "#{Rails.root}/public/401.html", :status => 401, :layout => false
  end

  def set_locale
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    I18n.locale = extract_locale_from_accept_language_header
    logger.debug "* Locale set to '#{I18n.locale}'"
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
    maps_path
  end

  def after_sign_out_path_for(resource_or_scope)
    about_path
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

end
