class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :require_admin!

  def index
    @users = User.order(created_at: :desc)
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_path, notice: 'User deleted.'
  end

  private
  def require_admin!
    redirect_to admin_login_path, alert: 'Please log in as admin.' unless session[:admin]
  end
end 