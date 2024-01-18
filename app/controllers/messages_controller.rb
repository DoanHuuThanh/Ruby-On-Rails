# frozen_string_literal: true

# Controller Messages
class MessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @message = current_user.messages.build(message_param)
    if @message.save
      SendMessageJob.perform_later(@message, current_user)
      respond_to(&:js)
    else
      respond_to do |format|
        format.js { render template: 'messages/error_message' }
      end
    end
  end

  def update
    @message = Message.find(params[:message][:id])
    if @message.present? && @message.update(message_param)
      UpdateMessageJob.perform_later(@message, current_user)
      respond_to(&:js)
    else
      respond_to do |format|
        format.js { render template: 'messages/error_message' }
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    if @message.present?
      DestroyMessageJob.perform_later(@message, current_user)
      @message.destroy
      respond_to(&:js)
    else
      respond_to do |format|
        format.js { render template: 'messages/error_message' }
      end
    end
  end

  private

  def message_param
    params.require(:message).permit(:conversation_id, :content, :status, :receiver)
  end
end
