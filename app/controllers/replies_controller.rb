class RepliesController < ApplicationController

  skip_before_action :verify_authenticity_token
  def create
    @comment = Comment.find_by(id: params[:comment_id])
    @reply = @comment.replies.build(reply_params)
    @reply.image.attach(params[:reply][:image])
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
    @reply = Reply.find(params[:reply_id])

    if @reply.update(reply_params)
      flash[:success] = 'Comment updated!'
      redirect_to root_path
    else
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 6)
      flash[:error] = 'Error updating comment'
      render 'static_pages/home'
    end
  end

  def destroy
    respond_to do |format|
      reply = Reply.find_by(id: params[:reply_id])
      reply.destroy
      format.js
    end
  end

  private

  def reply_params
    params.require(:reply).permit(:content, :comment_id, :image )
  end

end
