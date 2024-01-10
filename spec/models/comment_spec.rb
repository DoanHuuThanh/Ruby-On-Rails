# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user) { FactoryBot.create(:user) }
  describe 'comment' do
    it 'is valid' do
      micropost = FactoryBot.build(:micropost, user:)
      expect(micropost).to be_valid
    end

    it 'has a parent micropost' do
      micropost_with_parent = FactoryBot.create(:micropost, :with_parent, user:)
      expect(micropost_with_parent.parent_id).not_to be_nil
    end

    it 'raises an error if content is too long' do
      long_content = 'a' * 2001
      expect do
        FactoryBot.create(:micropost, content: long_content)
      end.to raise_error(ActiveRecord::RecordInvalid, /Content is too long/)
    end
  end
end
