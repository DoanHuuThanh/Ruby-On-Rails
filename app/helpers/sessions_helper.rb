# frozen_string_literal: true

# Module SessionHelper
module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id if user.present?
  end

  def current_user
    if (user_id = session[:user_id])
      @cunrent_user ||= User.find_by(id: session[:user_id])
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user&.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @cunrent_user = user
      end
    end
  end

  def current_user?(user)
    user && user == current_user
  end

  def logged_in?
    !current_user.nil?
  end

  def remember(user)
    return unless user.present?

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
    return if logged_in?

    store_location
    flash[:danger] = 'please log in.'
    redirect_to login_path
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end

  def activate
    udate_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

  def comment_owner
    @micropost = Micropost.find_by(id: params[:id])
    @user = @micropost.user
    redirect_to(root_url) unless @user == current_user
  end
end
