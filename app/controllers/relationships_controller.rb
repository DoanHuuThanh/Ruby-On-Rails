class RelationshipsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    redirect_to user
  end

  def destroy
    respond_to do |format|
      user = Relationship.find_by(followed_id: params[:user_id]).followed
      current_user.unfollow(user)
      format.html { redirect_to user }
      format.js
    end
  end
end
