module SessionsHelper
    def log_in(user)
        session[:user_id] = user.id
    end

  def current_user
    if (user_id = session[:user_id]) #ktra điều kiện session[:user_id] có giá trị hay ko nếu có thì được gán vào user_id
     @cunrent_user ||=  User.find_by(id:session[:user_id])
    elsif(user_id = cookies.encrypted[:user_id])
       user = User.find_by(id: user_id)
        if user && user.authenticated?(cookies[:remember_token])
          log_in user
          @cunrent_user = user
        end
    end
  end

  def logged_in?
    !current_user.nil?
  end



  def remember(user)
        user.remember
        cookies.permanent.encrypted[:user_id] = user.id
        cookies.permanent[:remember_token] = user.remember_token
  end

  def forget(user)
      user.forget
      cookies.delete(:user_id)
      cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    reset_session
    @cunrent_user = nil
end


def logged_in_user
  unless logged_in?
    flash[:danger]  = "please log in."
    redirect_to login_path
  end

end

end
