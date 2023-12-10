require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
     @user = User.new(name: "Vu Thanh Nam", email: "nam@gmail.com",password: "123456",password_confirmation: "123456")
  end

    test "should be valid " do
         assert @user.valid?
    end

    test "name should be present " do
      @user.name = "   "
      assert_not @user.valid?
    end

    test "email should be present " do
       @user.email = " "
       assert_not @user.valid?
    end

    test "email should not be regex " do
      assert @user.valid?, "#{@user.email} should be valid"
    end
end
