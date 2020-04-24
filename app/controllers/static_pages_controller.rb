class StaticPagesController < ApplicationController

  def home
    @feed_items = Micropost.all.paginate(page: params[:page])
  end

  def about

  end

end
