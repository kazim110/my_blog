class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find_by(id: params[:id])

    if @post.nil?
      head :not_found
      return
    end
  end
end
