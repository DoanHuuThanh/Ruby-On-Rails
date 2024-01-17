# frozen_string_literal: true

# spec/models/message_spec.rb

require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:user) { FactoryBot.create(:user) }

  context 'is valid' do
    subject { FactoryBot.create(:message, :conversation, user:) }
    it { should be_valid }
    let(:micropost_with_parent) { FactoryBot.create(:micropost, :with_parent, user:) }
    it { micropost_with_parent.should be_valid }
    it { micropost_with_parent.parent_id.should_not be_nil }
  end

  it { should validate_presence_of(:content) }

  it 'allows content with maximum length' do
    message = build(:message, content: 'a' * 2000)
    expect(message).to be_valid
  end
end
