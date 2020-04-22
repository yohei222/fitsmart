class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    binding.pry
    @user.save
    redirect_to action: :index
  end

  private
  def user_params
    params.require(:user).permit(:image)
  end
end
