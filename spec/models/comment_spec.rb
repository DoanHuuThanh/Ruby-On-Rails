# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user) { FactoryBot.create(:user) }
  describe 'comment' do
    context 'is valid' do
      subject { FactoryBot.build(:micropost, user:) }
      it { should be_valid }
      let(:micropost_with_parent) { FactoryBot.create(:micropost, :with_parent, user:) }
      it { micropost_with_parent.should be_valid }
      it { micropost_with_parent.parent_id.should_not be_nil }
    end

    context 'with validates comment' do
      subject { FactoryBot.build(:micropost, content: 'a' * 2001) }
      it { should_not be_valid }
      it { should validate_length_of(:content).is_at_most(2000).with_long_message('is too long (maximum is 2000 characters)') }
    end
  end
end
