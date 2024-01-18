# frozen_string_literal: true

# RoomChannel
class RoomChannel < ApplicationCable::Channel
  def subscribed
    room = params[:conversation_id]
    if room
      stream_from "room_channel_#{room}"
    else
      reject
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
