# frozen_string_literal: true

require 'test_helper'

class SessionsTest < ActionDispatch::IntegrationTest
  test 'should get new' do
    get login_path
    assert_response :success
  end
end
