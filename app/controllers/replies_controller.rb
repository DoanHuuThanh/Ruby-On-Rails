# frozen_string_literal: true

# Controller replies
class RepliesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @comment = Micropost.find_by(id: params[:parent_id])
    @reply = @comment.replies.build(content: params[:micropost][:content], parent_id: params[:parent_id])
    @reply.user = current_user
    if @reply.save
      flash[:success] = 'Comment created!'
      redirect_to root_path
    else
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 6)
      flash[:error] = 'Error creating comment'
      render 'static_pages/home'
    end
  end

  def update
    @comment = Micropost.find_by(id: params[:parent_id])
    @reply = @comment.replies.find(params[:reply_id])

    if @reply.update(reply_params)
      flash[:success] = 'Comment updated!'
      redirect_to root_path
    else
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 6)
      flash[:error] = 'Error updating comment'
      render 'static_pages/home'
    end
  end

  # not fixed yet
  def destroy
    respond_to do |format|
      comment = Micropost.find_by(id: params[:comment_id])
      reply = comment.replies.find(params[:reply_id])
      reply.destroy
      format.js
    end
  end

  private

  def reply_params
    params.require(:micropost).permit(:content)
  end
end
