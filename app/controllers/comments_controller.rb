# frozen_string_literal: true

# Controller Comments
class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :user_fix_comment?, only: %i[update destroy]
  def create
    id = params[:micropost][:micropost_id]
    if id.present?
      @micropost = Micropost.find_by(id: id)
      @comment = @micropost.comments.build(comment_params)
      @comment.image.attach(params[:micropost][:image])
      @comment.user = current_user
    else
      flash[:error] = 'Error'
      render 'static_pages/home'
    end
    if @comment.save
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
    if !@comment.nil? && @comment.update(comment_params)
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
    if !comment.nil?
      comment.destroy
      respond_to(&:js)
    else
      flash[:error] = 'Error! destroy comment'
    end
  end

  private

  def comment_params
    params.require(:micropost).permit(%i[content parent_id image])
  end
end
