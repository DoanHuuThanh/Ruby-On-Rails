# frozen_string_literal: true

<<<<<<< HEAD
=======
# Controller responsible for handling account activations.
>>>>>>> comment3
class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      session.delete(:user_id)
      log_in user
      flash[:success] = 'Account activated'
      redirect_to user
    else
      flash[:danger] = 'Invalid activation link'
      redirect_to root_path
    end
  end
end
