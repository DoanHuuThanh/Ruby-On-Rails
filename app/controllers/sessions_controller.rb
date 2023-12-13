class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
                session.delete(:user_id)
                log_in user
                params[:session][:remember_me] == '1' ? remember(user) : forget(user)
               friendly_forward_or(user)
      else
        flash.now[:danger] = "Invalid email/password combination"
        render 'new'
  end
end

def destroy
  log_out if logged_in?
  redirect_to login_path
  end


  def friendly_forward_or(user)

    if session[:forwarding_url]

         redirect_to session[:forwarding_url]
         session.delete(:forwarding_url)

    else
        redirect_to root_path
    end

  end

end
