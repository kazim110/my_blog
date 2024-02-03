class UsersController < ApplicationController
  layout 'application'

  before_action :authenticate_user!

  def index
    @users = User.includes(:posts).all
  end

  def show
    @user = User.find(params[:id])
    @recent_posts = @user.recent_posts
    @all_posts = @user.posts
  end
end
