require "test_helper"

class MicropostTest < ActiveSupport::TestCase
 def setup
      @user = users(:michael)
      @microposts = Micropost.new(content: "lorem", user_id: @user.id)
 end

   test "should be valid" do
       assert @microposts.valid?
   end

    test "user is should be parent" do
       @microposts.user_id = nil
       assert_not @microposts.valid?
    end

    test "content should be present" do
        @microposts.content = "  "
        assert_not @microposts.valid?
    end

    test "content should be at most 300 characters" do
      @microposts.content = "a" * 3000
      assert_not @microposts.valid?
      end
end
