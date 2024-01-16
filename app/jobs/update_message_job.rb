# frozen_string_literal: true

# UpdateMessageJob
class UpdateMessageJob < ApplicationJob
  queue_as :default

  def perform(message, _current_user)
    if message.conversation_id.present?
      ActionCable.server.broadcast("room_channel_#{message.conversation_id}", { mes_id: message.id, content: message.content, action: 'update', status: message.status })
    end
    return unless message.receiver.present?

    ActionCable.server.broadcast("room_channel_#{message.receiver + message.user_id}", { mes_id: message.id, content: message.content, action: 'update', status: message.status })
  end
end
