# frozen_string_literal: true

# DestroyMessageJob
class DestroyMessageJob < ApplicationJob
  queue_as :default

  def perform(message, _current_user)
    ActionCable.server.broadcast("room_channel_#{message.conversation_id}", { mes_id: message.id, action: 'destroy' }) if message.conversation_id.present?
    return unless message.receiver.present?

    ActionCable.server.broadcast("room_channel_user_#{message.receiver + message.user_id}", { mes_id: message.id, action: 'destroy' })
  end
end
