class UsersController < ApplicationController

  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :chart]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.order(updated_at: :desc).paginate(page: params[:page])
    if params[:q] && params[:q].reject { |key, value| value.blank? }.present?
      @q = User.ransack(search_params, activated_true: true)
      @title = "検索結果"
    else
      @q = User.ransack(activated_true: true)
      @title = "全てのユーザー"
    end
    @users = @q.result.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    if params[:q] && params[:q].reject { |key, value| value.blank? }.present?
      @q = @user.microposts.ransack(microposts_search_params)
      @microposts = @q.result.paginate(page: params[:page])
      @title = "検索結果 | #{@user.name}"
    else
      @q = Micropost.none.ransack
      @microposts = @user.microposts.paginate(page: params[:page])
      @title = @user.name
    end
    @url = user_path(@user)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Fit Smartへようこそ！"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user.email = 'guest1234@gmail.com'
      flash[:danger] = "ゲストユーザーはユーザー情報を更新できません"
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "プロフィール情報が更新されました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to users_url
  end

  def chart
    @user = User.find(params[:id])
    @microposts = @user.microposts
    @records = @microposts.map{ |micropost| micropost.records }
    @exercise1 = []
    @exercise2 = []
    @exercise3 = []
    @exercise4 = []
    @exercise5 = []
    @exercise6 = []
    @exercise7 = []
    @exercise8 = []
    @records.each do |record|
      record = record.first
      if record.exercise_id == 1
        @exercise1 << record
      elsif record.exercise_id == 2
        @exercise2 << record
      elsif record.exercise_id == 3
        @exercise3 << record
      elsif record.exercise_id == 4
        @exercise4 << record
      elsif record.exercise_id == 5
        @exercise5 << record
      elsif record.exercise_id == 6
        @exercise6 << record
      elsif record.exercise_id == 7
        @exercise7 << record
      elsif record.exercise_id == 8
        @exercise8 << record
      end
    end
    if @exercise1.empty? && @exercise2.empty? && @exercise3.empty? && @exercise4.empty? && @exercise5.empty? && @exercise6.empty? && @exercise7.empty? && @exercise8.empty?
      flash[:danger] = "トレーニング履歴がありません"
    end
  end

  private
  def search_params
    params.require(:q).permit(:name_cont)
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :sex, :status)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def microposts_search_params
    params.require(:q).permit(:title_or_content_cont)
  end

end
