require "test_helper"

class UsersLoginTestTest < ActionDispatch::IntegrationTest
    test " login with invalid  informartion" do
       get login_path
       assert_template 'sessions#new'
       post login_path, params: {session: {email: "", password: ""}}
       assert_template 'sessions#create'
       assert_not flash.empty?
       get root_path
       assert flash.empty?
    end

    test "login with partial " do
        get login_path
        assert_template partial: '_header'
    end

    def setup
      @user = users(:michael) # được lấy trong file fixtures trong test  là 1 file cung cấp dữ lieuẹ mẫu để test
    end

    test "login with valid information 2" do
      get login_path
      post login_path, params: { session: { email: @user.email,password: 'password' } }
      assert is_logged_in?
      assert_redirected_to root_path #iểm tra xem yêu cầu có được chuyển hướng đến root_path hay không. Nếu không, sẽ kích hoạt lỗi kiểm thử.
      follow_redirect!#Nếu yêu cầu đã được chuyển hướng, follow_redirect! sẽ thực hiện chuyển hướng và làm cho trang web hiển thị trang mới sau chuyển hướng.
      assert_template 'static_pages/home'
      assert_select "a[href=?]", login_path, count: 0
      assert_select "a[href=?]", logout_path
      assert_select "a[href=?]", user_path(@user) # là 1 url được sử dụng để tạo ra đường dẫn đến trang cá nhân của người dùng có ID là @user
      # là có vì có hàm curent_user là 1 đường dẫn tới user có id tương ứng
      get logout_path
      assert_not is_logged_in? # trả về false vì lúc này session[:user_id] là nil mà hàm trả về giá trị ngc lại nên  trả về false
      assert_redirected_to login_path
      follow_redirect!
      assert_select "a[href=?]", login_path
      assert_select "a[href=?]", logout_path, count: 0
      assert_select "a[href=?]", user_path(@user), count: 0
      end


end
