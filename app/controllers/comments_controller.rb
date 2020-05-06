class CommentsController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def create
    @micropost = Micropost.find(params[:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "コメントしました"
      redirect_to micropost_path(@micropost)
    else
      unless @comment.content.empty?
        flash[:danger] = "コメントできませんでした"
      else
        flash[:danger] = "コメントは20文字以下で入力してください"
      end
      redirect_to micropost_path(@micropost)
    end
  end

  def destroy
    @micropost = Micropost.find(params[:micropost_id])
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    flash[:success] = "コメントを削除しました"
    redirect_to micropost_path(@micropost)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
