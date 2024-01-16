# frozen_string_literal: true

# RoomChannel
class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel_#{params[:conversation_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
