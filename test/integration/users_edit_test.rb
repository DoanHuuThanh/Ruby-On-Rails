require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
          @user = users(:michael)
    end

  test "unsuccessful edit" do
    log_in_as @user
      get edit_user_path(@user)
      assert_template "users/edit"
      patch user_path(@user), params: { user: { name: "", email: "thanh@gmail.com", password: "123", password_confirmation: "1234"}}

      assert_template "users/edit"

  end


  test "successful edit" do
    log_in_as @user
    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path(@user), params: { user: { name: "thanh", email: "thanh@gmail.com", password: "123", password_confirmation: "123"}}
     assert_redirected_to user_path
     follow_redirect!
     assert_template "users/show"

end
end
