class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource

  def index
    current_user_ip = remote_ip
    if current_user_ip == '68.59.14.222'
      current_user_coords = [42.4257, -83.0437]
    else
      current_user_coords = Geocoder.search(current_user_ip).first.coordinates
    end

    @posts = Post.near(current_user_coords, 100000, :order => false)
             .where(created_at: (Time.now - 100000.days)..Time.now)
             .order(updated_at: :desc).page params[:page]
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = current_user.posts.build
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.ip_address = remote_ip
    @post.set_lat_lon(@post.ip_address)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_path }
      format.js
    end
  end

  def upvote
    @post = Post.find(params[:id])
    @post.upvote_by current_user

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  def downvote
    @post = Post.find(params[:id])
    @post.downvote_by current_user

    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
  end

  private
    def post_params
      params.require(:post).permit(:content, :picture)
    end
end
