class PostsController < ApplicationController
  http_basic_authenticate_with name: "mk", password: "secret",
  except: [:index, :show]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    user_ip = request.remote_ip
    if user_ip == "127.0.0.1"
      @user_coords = [41.925127, -87.655331]
    else
      @user_coords = Geocoder.coordinates(user_ip)
    end
    #coords for library should be users
    @posts = Post.near(@user_coords, 5).where(created_at: (Time.now - 1.hour)..Time.now).order(created_at: :desc)
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
    # render plain: params[:post].inspect

    # @post = Post.new(params[:post])
    # strong parameters ... req us to tell rails what params are allowed
    # @post = Post.new(params.require(:post).permit(:text))
    # the above line is often factored into own method so that it can be reused
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post
    else
      render 'new'
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

    redirect_to posts_path
  end

  def upvote
    @post = Post.find(params[:id])
    @post.upvote_by current_user

    redirect_back(fallback_location: root_path)
  end

  def downvote
    @post = Post.find(params[:id])
    @post.downvote_by current_user

    redirect_back(fallback_location: root_path)
  end

  private
    def post_params
      params.require(:post).permit(:content)
    end
end
