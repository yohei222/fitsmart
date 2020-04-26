class StaticPagesController < ApplicationController

  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = Micropost.all.paginate(page: params[:page], per_page: 7)
    end
  end

  def about

  end

end
