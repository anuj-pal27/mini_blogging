class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @post, notice: 'Comment was successfully created.'
    else
      redirect_to @post, alert: 'Comment cannot be blank.'
    end
  end

  private
    def set_post
      @post = Post.find_by!(slug: params[:post_slug])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end
end 