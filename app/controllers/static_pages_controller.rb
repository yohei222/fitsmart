class StaticPagesController < ApplicationController

  def home
    if logged_in?
      if params[:q] && params[:q].reject { |key, value| value.blank? }.present?
        @q =  Micropost.includes([:records, :likes]).ransack(microposts_search_params)
        @title = "検索結果"
        @feed_items = @q.result.paginate(page: params[:page], per_page: 7)
      else
        @q = Micropost.none.ransack
        @title = "投稿一覧"
        @feed_items = Micropost.includes([:records, :likes]).paginate(page: params[:page], per_page: 7)
      end
      @url = root_path
    end
  end

  private
    def microposts_search_params
      params.require(:q).permit(:title_or_content_cont)
    end

end
