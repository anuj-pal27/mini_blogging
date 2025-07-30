class Admin::DashboardController < ApplicationController
  layout 'admin'
  before_action :require_admin!

  def index
  end

  private
  def require_admin!
    redirect_to admin_login_path, alert: 'Please log in as admin.' unless session[:admin]
  end
end 