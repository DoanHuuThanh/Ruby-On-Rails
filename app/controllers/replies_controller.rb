# frozen_string_literal: true

# Controller replies
class RepliesController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @comment = Comment.find_by(id: params[:parent_id])
    @reply = @comment.replies.build(content: params[:comment][:content], parent_id: params[:parent_id],
                                    micropost_id: params[:micropost_id])
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
    @comment = Comment.find_by(id: params[:parent_id])
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
      comment = Comment.find_by(id: params[:parent_id])
      reply = comment.find_by(id: params[:reply_id])
      reply.destroy
      format.js
    end
  end

  private

  def reply_params
    params.require(:comment).permit(:content)
  end
end
