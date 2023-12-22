require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test 'layout links ' do
    get root_path
    assert_template 'static_pages/home' # assert_template 'home' là một câu lệnh kiểm tra sự khớp giữa
    # template hiện tại được render và template được mong đợi.
    # Trong trường hợp này, nó kiểm tra xem template hiện tại có phải là "home.html.erb" hay không.
    assert_select 'a[href=?]', root_path, count: 1
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', about_path
  end
end
