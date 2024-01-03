# frozen_string_literal: true

require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  include Rails.application.routes.url_helpers
  def setup
    @base_title = 'Ruby on Rails Tutorial Sample App'
  end

  test 'should get root' do
    get root_path
    assert_response :success
  end

  test 'should get home' do
    get home_path # dùng method get để  thực hiện 1 HTTP GET request đến static_pages_home_url/điều này giả định rằng có 1 action
    # tên là home trong StaticPagéController action này cần trả về 1 trang thành công ( HTTP 200 OK)
    assert_response :success # ktra respond có phải là 200 ko
    assert_select 'title', "Home | #{@base_title}"
  end

  test 'should get help' do
    get help_path
    assert_response :success
    assert_select 'title', "Help | #{@base_title}"
  end

  test 'should get about' do
    get about_path
    assert_response :success
    assert_select 'title', "About | #{@base_title}"
  end
end
