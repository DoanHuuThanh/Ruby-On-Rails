# frozen_string_literal: true

# Controller Comments
class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :correct_user?, only: %i[update destroy]
  def create_comment
    @micropost = Micropost.find_by(id: params[:micropost_id])
    @comment = @micropost.comments.build(content: params[:micropost][:content], parent_id: params[:parent_id])
    @comment.image.attach(params[:micropost][:image])
    @comment.user = current_user
    if @comment.save
      flash[:success] = 'Comment created!'
      redirect_to root_path
    else
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 6)
      flash[:error] = 'Error creating comment'
      render 'static_pages/home'
    end
  end

  def create_reply
    @comment = Micropost.find_by(id: params[:parent_id])
    @reply = @comment.replies.build(content: params[:micropost][:content], parent_id: params[:parent_id])
    @reply.image.attach(params[:micropost][:image])
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
    @comment = Micropost.find_by(id: params[:id])
    if @comment.update(content: params[:micropost][:content])
      flash[:success] = 'Comment updated!'
      redirect_to root_path
    else
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 6)
      flash[:error] = 'Error updating comment'
      render 'static_pages/home'
    end
  end

  def destroy
    comment = Micropost.find_by(id: params[:id])
    comment.destroy
    respond_to(&:js)
  end
end
