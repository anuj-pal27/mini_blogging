class Admin::PostsController < ApplicationController
  layout 'admin'
  before_action :require_admin!

  def index
    @posts = Post.order(created_at: :desc)
  end

  def destroy
    @post = Post.find_by!(slug: params[:id])
    @post.destroy
    redirect_to admin_posts_path, notice: 'Post deleted.'
  end

  private
  def require_admin!
    redirect_to admin_login_path, alert: 'Please log in as admin.' unless session[:admin]
  end
end 