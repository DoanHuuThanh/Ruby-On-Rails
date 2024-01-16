# frozen_string_literal: true

# SendMessageJob
class SendMessageJob < ApplicationJob
  queue_as :default

  def perform(message, current_user)
    mine = ApplicationController.render(
      partial: 'messages/mine',
      locals: { message:, current_user: }
    )

    theirs = ApplicationController.render(
      partial: 'messages/theirs',
      locals: { message:, current_user: }
    )
    ActionCable.server.broadcast("room_channel_#{message.conversation_id}", { mine:, their: theirs, message:, action: 'create' }) if message.conversation_id.present?
    return unless message.receiver.present?

    ActionCable.server.broadcast("room_channel_#{message.receiver + message.user_id}", { mine:, their: theirs, message:, action: 'create' })
  end
end
