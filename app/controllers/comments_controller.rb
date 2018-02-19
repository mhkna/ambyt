class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.html { redirect_to posts_path }
        format.js
      end
    else
      respond_to do |format|
        format.html { redirect_to post_path(@post) }
        format.js
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to post_path(@post) }
      format.js
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
