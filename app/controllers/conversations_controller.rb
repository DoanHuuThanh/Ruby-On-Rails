# frozen_string_literal: true

# Controller Conversations
class ConversationsController < ApplicationController
  before_action :set_room, only: [:show]
  before_action :set_user, only: [:user_conversation]
  def show
    @rooms = current_user.conversation_members
    @users = User.all_except(current_user)
    render 'index'
  end

  def user_conversation
    @rooms = current_user.conversation_members
    @users = User.all_except(current_user)
    render 'index'
  end

  def index
    @rooms = current_user.conversation_members
    @users = User.all_except(current_user)
  end

  def create
    @conversation = Conversation.new(room_params)
    if @conversation.save
      current_user.add_group(@conversation)
      redirect_to @conversation
    else
      render 'new'
    end
  end

  def set_room
    @room = Conversation.find(params[:id])
  end

  def set_user
    @user = User.find(params[:id])
  end

  private

  def room_params
    params.require(:conversation).permit(:name)
  end
end
