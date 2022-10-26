class PostsController < ApplicationController
  def index
    @posts = Post.includes(:user).all
  end

  def new
    @post = Post.new
  end
end
