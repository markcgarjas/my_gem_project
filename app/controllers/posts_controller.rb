class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post_params, only: [:show, :edit, :update, :destroy]
  before_action :validate_post_owner, only: [:edit, :update, :destroy]

  def index
    @posts = Post.includes(:user).all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "Post was created successfully."
      redirect_to posts_path
    else
      render :new, status: :unprocessable_entity
    end
  end
  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    if @posts.update(post_params)
      # @post.user = current_user
      flash[:notice] = "Post was updated successfully."
      redirect_to posts_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @posts.destroy
    redirect_to posts_path
  end

  private

  def set_post_params
    @posts = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :content)
  end

  def validate_post_owner
    unless @posts.user == current_user
      flash[:notice] = 'the post not belongs to you'
      redirect_to posts_path
    end
  end
  end
