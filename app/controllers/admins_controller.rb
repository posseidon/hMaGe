class AdminsController < ApplicationController
  def users
    @users = User.where("role <> 'admin'").order(:email).page params[:page]
  end

  def search

  end

  def update
    User.update(params['users'].keys, params['users'].values)
    redirect_to users_admins_path
  end
end
