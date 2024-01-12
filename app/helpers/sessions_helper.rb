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
    @comment = Micropost.find_by(id: params[:id])
    @user = @comment.user
    redirect_to(root_url) unless @user == current_user
  end

  def render_reaction_icon(action_type)
    case action_type
    when 'like' || 0
      image_tag('like.svg', class: 'icon transition ease-in-out delay-150 hover:-translate-y-1 hover:scale-110 duration-300')
    when 'love' || 1
      image_tag('love.svg', class: 'icon transition ease-in-out delay-150 hover:-translate-y-1 hover:scale-110 duration-300')
    when 'haha' || 2
      image_tag('haha.svg', class: 'icon transition ease-in-out delay-150 hover:-translate-y-1 hover:scale-110 duration-300')
    when 'wow' || 3
      image_tag('wow.svg', class: 'icon transition ease-in-out delay-150 hover:-translate-y-1 hover:scale-110 duration-300')
    when 'sad' || 4
      image_tag('sad.svg', class: 'icon transition ease-in-out delay-150 hover:-translate-y-1 hover:scale-110 duration-300')
    when 'angry' || 5
      image_tag('angry.svg', class: 'icon transition ease-in-out delay-150 hover:-translate-y-1 hover:scale-110 duration-300')
    end
  end
end
