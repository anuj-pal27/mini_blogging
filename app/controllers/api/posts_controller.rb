class Api::PostsController < ApplicationController
  before_action :authenticate_api_token!
  skip_before_action :verify_authenticity_token

  def index
    posts = Post.where(status: 'published').order(created_at: :desc)
    render json: posts.as_json(only: [:title, :body, :slug, :created_at, :updated_at])
  end

  def show
    post = Post.find_by!(slug: params[:slug], status: 'published')
    render json: post.as_json(only: [:title, :body, :slug, :created_at, :updated_at])
  end

  private
  def authenticate_api_token!
    token = request.headers['Authorization'].to_s.remove('Bearer ').presence || params[:token]
    unless token && ActiveSupport::SecurityUtils.secure_compare(token, ENV.fetch('API_TOKEN', 'secret123'))
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end 