class Admin::SessionsController < ApplicationController
  layout 'admin'

  def new
  end

  def create
    if params[:username] == 'admin' && params[:password] == 'admin123'
      session[:admin] = true
      redirect_to admin_dashboard_path, notice: 'Logged in as admin.'
    else
      flash.now[:alert] = 'Invalid credentials.'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:admin)
    redirect_to admin_login_path, notice: 'Logged out.'
  end
end 