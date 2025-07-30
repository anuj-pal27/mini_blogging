class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all.order(created_at: :desc)
    # Search by title/content
    if params[:q].present?
      q = params[:q].downcase
      @posts = @posts.where("LOWER(title) LIKE ? OR LOWER(body) LIKE ?", "%#{q}%", "%#{q}%")
    end
    # Filter by status
    if params[:status].present?
      @posts = @posts.where(status: params[:status])
    end
    # Filter by own posts
    if user_signed_in? && params[:own].present?
      @posts = @posts.where(user_id: current_user.id)
    end
    # Filter by date range
    if params[:from].present?
      @posts = @posts.where("created_at >= ?", Date.parse(params[:from]).beginning_of_day)
    end
    if params[:to].present?
      @posts = @posts.where("created_at <= ?", Date.parse(params[:to]).end_of_day)
    end
  end

  def dashboard
    @posts = current_user.posts.order(created_at: :desc)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url, notice: "Post was successfully destroyed."
  end

  private
    def set_post
      @post = Post.find_by!(slug: params[:slug])
    end

    def post_params
      params.require(:post).permit(:title, :body, :status)
    end
end
