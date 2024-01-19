# frozen_string_literal: true

# Controller Micropost
class MicropostsController < ApplicationController
  before_action :logged_in_user, only: %i[create destroy]
  skip_before_action :verify_authenticity_token

  def show
    @micropost = Micropost.find(params[:id])
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.image.attach(params[:micropost][:image])
    if @micropost.save
      flash[:success] = 'Micropost created!'
      redirect_to home_path
    else
      flash[:danger] = 'Micropost creation failed. Please check the content.'
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 6)
      render 'static_pages/home'
    end
  end

  def destroy
    respond_to do |format|
      micropost = current_user.microposts.find_by(id: params[:mic_id_delete])
      micropost.destroy

      format.js
    end
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :image)
  end
end
