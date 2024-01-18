# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RoomChannel, type: :channel do
  let(:user) { FactoryBot.create(:user) } # Assuming you have a User model

  before do
    stub_connection user_id: user.id
  end

  it 'subscribes to the room channel successfully' do
    subscribe(conversation_id: 'conversation_id')
    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from('room_channel_conversation_id')
  end

  it 'rejects subscription when conversation_id is not provided' do
    subscribe
    expect(subscription).to be_rejected
  end

  it 'subscribes to a stream when room id is provided' do
    subscribe(conversation_id: 42)

    expect(subscription).to be_confirmed
    expect(subscription).to have_stream_from('room_channel_42')
  end
end
