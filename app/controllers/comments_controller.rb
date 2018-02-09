class CommentsController < ApplicationController
  http_basic_authenticate_with name: "mk", password: "secret",
  only: :destroy

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    if @comment.save
      @post.touch
    end

    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    redirect_to post_path(@post)
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
