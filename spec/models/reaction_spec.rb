# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reaction, type: :model do
  describe 'validations' do
    let(:user) { FactoryBot.create(:user) }
    let(:micropost) { FactoryBot.create(:micropost, user:) }
    subject { FactoryBot.create(:reaction, micropost:) }
    it { should validate_numericality_of(:action).only_integer.is_greater_than_or_equal_to(0).is_less_than_or_equal_to(5) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:micropost) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:reaction)).to be_valid
    end
  end
end
