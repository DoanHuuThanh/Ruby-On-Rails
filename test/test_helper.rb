# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!
module ActiveSupport
  class TestCase
    include ApplicationHelper
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    def is_logged_in?
      !session[:user_id].nil?
    end

    def log_in_as(user, password: 'password', remember_me: '1')
      post login_path, params: { session: { email: user.email, password:, remember_me: } }
    end

    # Add more helper methods to be used by all tests here...
  end
end
