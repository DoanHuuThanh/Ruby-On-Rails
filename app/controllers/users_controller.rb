# frozen_string_literal: true

# Controller User
class UsersController < ApplicationController
  before_action :admin_user, only: :destroy
  skip_before_action :verify_authenticity_token

  def index
    @users = User.paginate(page: params[:page], per_page: 12)
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user
      @microposts = @user.microposts.paginate(page: params[:page])
      respond_to do |format|
        format.html
        format.js
      end
    else
      flash[:alert] = 'User does not exist'
      redirect_to root_path
    end
  end

  def following
    @title = 'Following'
    @user = User.find_by(id: params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Follower'
    @user = User.find_by(id: params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def destroy
    respond_to do |format|
      user = User.find_by(id: params[:user_id_delete])
      user&.destroy
      format.js
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
