class Admin::UsersController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def list
    @users = User.where("role <> 'admin'").order(:email).page params[:page]
  end

  def search

  end

  def update
    User.update(params['users'].keys, params['users'].values)
    redirect_to list_admin_users_path
  end
end
