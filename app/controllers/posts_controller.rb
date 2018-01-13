class PostsController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :show]
  def index
    user_ip = remote_ip
    user_coordinates = Geocoder.coordinates(user_ip)
    @posts = Post.display_in_ambyt(user_coordinates, 10000000000)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(params[:post].permit(:content))
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end
end
