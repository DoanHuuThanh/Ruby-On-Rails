# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should have a valid factory' do
    user = create(:user)
    expect(user).to be_valid
  end
end
