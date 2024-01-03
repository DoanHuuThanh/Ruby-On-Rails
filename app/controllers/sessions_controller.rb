class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        session.delete(:user_id)
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        friendly_forward_or(user)
      else
        message = 'Account not activated'
        message += 'Check your email for the activation link'
        flash[:warning] = message
        redirect_to root_path
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def use_omniauth
    auth_hash = request.env['omniauth.auth']
    if auth_hash
      user = User.from_omniauth(auth_hash)
      log_in user
      remember(user)
      redirect_to root_path
    else
      flash[:alert] = 'Please try again.'
      redirect_to login_path
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to login_path
  end

  def friendly_forward_or(_user)
    if session[:forwarding_url]

      redirect_to session[:forwarding_url]
      session.delete(:forwarding_url)

    else
      redirect_to root_path
    end
  end
end
