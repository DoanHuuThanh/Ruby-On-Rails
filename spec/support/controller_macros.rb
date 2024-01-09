# frozen_string_literal: true

# spec/support/controller_macros.rb
module ControllerMacros
  def log_in(user)
    session[:user_id] = user.id
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
end
