module SessionsHelper
  #tạo session
    def log_in(user)
        session[:user_id] = user.id
    end

    # người dùng đăng nhập
  def current_user
    if (user_id = session[:user_id]) #ktra điều kiện session[:user_id] có giá trị hay ko nếu có thì được gán vào user_id
     @cunrent_user ||=  User.find_by(id:session[:user_id])
    elsif(user_id = cookies.encrypted[:user_id])
       user = User.find_by(id: user_id)
        if user && user.authenticated?(:remember,cookies[:remember_token])
          log_in user
          @cunrent_user = user
        end
    end
  end

  #ktra user hiện tại có giá trị hay ko và nó có phải là user đang đăng nhập ko
  def current_user? user
       user && user == current_user
  end

   #ktra đăng nhập nếu đăng nhập là true, chưa đăng nhập là false
  def logged_in?
    !current_user.nil?
  end


   #lưu ng dùng rên cookies
  def remember(user)
        user.remember
        cookies.permanent.encrypted[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
  end

    #xóa ng dùng khỏi cookies
  def forget(user)
      user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
  end

   #đăng xuất
  def log_out
    forget(current_user)
    reset_session
    @cunrent_user = nil
end

   #ghi nhớ trang dùng vừa ấn để sau khi đăng nhập về trang đó
def logged_in_user
  unless logged_in?
    store_location
    flash[:danger]  = "please log in."
    redirect_to login_path
  end
end
  #lưu trang vừa ấn vào 1 session
def store_location
   session[:forwarding_url] = request.original_url if request.get?

end

def activate
  udate_attribute(:activated, true)
  update_attribute(:activated_at,Time.zone.now)
end

def send_activation_email
     UserMailer.account_activation(self).deliver_now
end

end
