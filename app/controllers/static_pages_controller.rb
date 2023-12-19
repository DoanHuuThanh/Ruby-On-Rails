class StaticPagesController < ApplicationController
  def home
    if logged_in?
    @micropost = current_user.microposts.build
    @feed_items = current_user.feed.paginate(page: params[:page], per_page: 6)
    #khi post sai sẽ xảy ra lỗi và sẽ ko có @feed_item vì lúc này điều hg ko tới trang home_path mà là tới controler micropost , action "create"
    #đơn giản là vì khi sai nó cỉ render ra view của home này và vẫn giữ nguyên controler và action của hành động đó
    end
  end

  def help
  end

  def about

  end
end
