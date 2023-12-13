require "test_helper"

class UserIndexTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
    end

   test "index including pagination" do
      log_in_as @user
      get users_path
      assert_template "users/index"



   end

end
