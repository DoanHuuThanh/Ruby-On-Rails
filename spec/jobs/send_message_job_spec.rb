# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SendMessageJob, type: :job do
  include ActiveJob::TestHelper
  let(:user) { FactoryBot.create(:user) }
  let(:message_conversation) { FactoryBot.create(:message, :conversation, user:) }
  let(:message_user) { FactoryBot.create(:message, :receiver, user:) }

  subject(:job) { SendMessageJob.perform_later(user, message_conversation) }

  it 'queues the job' do
    expect { job }.to have_enqueued_job(SendMessageJob)
      .with(user, message_conversation)
      .on_queue('default')
  end

  it 'is in default queue' do
    expect(SendMessageJob.new.queue_name).to eq('default')
  end

  it 'executes perform' do
    expect(ActionCable.server).to receive(:broadcast).with(
      "room_channel_#{message_conversation.conversation_id}",
      hash_including(action: 'create')
    )
    perform_enqueued_jobs { job }
  end
end
