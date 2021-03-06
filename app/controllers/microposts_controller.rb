class MicropostsController < ApplicationController
  include MicropostsHelper

  before_action :logged_in_user, only: [:new, :create, :show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update, :destroy]

  def new
    @micropost = current_user.microposts.new
    @micropost.records.build
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if duplicate_exercise?(@micropost)
      flash.now[:danger] = "トレーニングの種目が重複しています"
      render 'new' and return
    end
    if @micropost.save
      flash[:success] = "投稿されました！"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def show
    @micropost = Micropost.find_by(id: params[:id])
    @comments = @micropost.try(:comments)
    @comment = Comment.new
  end

  def edit

  end

  def update
    if duplicate_exercise?(@micropost)
      flash.now[:danger] = "トレーニングの種目が重複しています"
      render 'new' and return
    end
    if @micropost.update(micropost_params)
      flash[:success] = "投稿が更新されました"
      redirect_to micropost_path(@micropost)
    else
      render 'edit'
    end
  end

  def destroy
    @micropost = Micropost.find_by(id: params[:id])
    @micropost.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:title, :content, :picture, records_attributes: [:id, :exercise_id, :weight, :times, :sets, :_destroy])
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil? && !current_user.admin?
  end

end