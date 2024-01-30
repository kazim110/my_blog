class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])

    return unless @user.nil?
      head :not_found
    end
  end
end
