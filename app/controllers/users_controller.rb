# frozen_string_literal: true

# Controller User
class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[edit update index destroy following followers]
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: :destroy
  skip_before_action :verify_authenticity_token

  def index
    @users = User.paginate(page: params[:page], per_page: 12)
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by(id: params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
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

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:success] = 'Please check your email address for avtivate your account'
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'User updated successfully'
      redirect_to @user
    else
      render 'edit'
    end
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
