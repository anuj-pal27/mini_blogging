class Admin::CommentsController < ApplicationController
  layout 'admin'
  before_action :require_admin!

  def index
    @comments = Comment.order(created_at: :desc)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to admin_comments_path, notice: 'Comment deleted.'
  end

  private
  def require_admin!
    redirect_to admin_login_path, alert: 'Please log in as admin.' unless session[:admin]
  end
end 