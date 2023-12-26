class CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @micropost = Micropost.find_by(id: params[:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    @comment.image.attach(params[:comment][:image])
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

  def update
    @comment = Comment.find(params[:comment_id])

    if @comment.update(comment_params)
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
      comment = Comment.find_by(id: params[:comment_id])
      comment.destroy
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :micropost_id, :image )
  end
end
