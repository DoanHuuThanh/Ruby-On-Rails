# frozen_string_literal: true

# Controller Application
class ApplicationController < ActionController::Base
  include SessionsHelper
  include UsersHelper
end
