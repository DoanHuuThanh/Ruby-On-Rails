# frozen_string_literal: true

# Controller Comments
class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :comment_owner, only: %i[update destroy]

  def create
    @comment = Micropost.build(comment_params)
    @comment.user = current_user
    if @comment.save
      respond_to(&:js)
    else
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 6)
      respond_to do |format|
        format.js { render 'error.js.erb' }
      end
    end
  end

  def update
    respond_to do |format|
      unless @comment.present? && @comment.update(comment_params)
        @feed_items = current_user.feed.paginate(page: params[:page], per_page: 6)
        format.html { render 'static_pages/home' }
      end
      format.js
    end
  end

  def destroy
    if @comment.present?
      @comment.destroy
      respond_to(&:js)
    else
      flash[:error] = 'Error! destroy comment'
    end
  end

  private

  def comment_params
    params.require(:micropost).permit(:parent_id, :content, :image)
  end
end
