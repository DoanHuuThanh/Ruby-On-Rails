class UsersController < ApplicationController
  before_action :logged_in_user, only: %i[edit update index destroy following followers] # trc khi thực hiện các hành động edit,update trong controller,
  # hãy gọi phương thức logged_in_user
  before_action :correct_user, only: %i[edit update]
  before_action :admin_user, only: :destroy
  #  Các hành động xử lý yêu cầu từ API dùng skip_before_action :verify_authenticity_token
  skip_before_action :verify_authenticity_token # Rails sẽ không kiểm tra CSRF token cho các hành động trong controller đó.

  def index
    @users = User.paginate(page: params[:page], per_page: 12)
    # phương thức paginate được cung cấp bởi gem phân trang, cho phép chia kết quả truy vấn thành các trang.
    # page: params[:page]: Đọc trang hiện tại từ tham số URL. Thường là một số nguyên chỉ định trang hiện tại.
    # per_page: 10: Chỉ định số lượng bản ghi hiển thị trên mỗi trang. Trong trường hợp này, là 10 bản ghi trên mỗi trang.
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by(id: params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def following
    @title = 'Following'
    @user = User.find_by(id: params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = 'Follower'
    @user = User.find_by(id: params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:success] = 'Please check your email address for avtivate your account'
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = 'User updated successfully'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    respond_to do |format|
      user = User.find_by(id: params[:user_id_delete])
      user.destroy if user
      format.js
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
    # params.require(:user): Phương thức require đảm bảo rằng trong params, có một tham số tên là :user tồn tại.
    # Nếu không, nó sẽ ném một ngoại lệ (ActionController::ParameterMissing).
    # .permit(:name, :email, :password, :password_confirmation): Phương thức permit xác định danh sách các tham số mà bạn
    # cho phép được chấp nhận trong hash params[:user]. Nếu một tham số không nằm trong danh sách này, nó sẽ bị loại bỏ.
  end

  def correct_user
    @user = User.find(params[:id]) # user mà mình đã đăng nhập và muốn sửa nó
    # chuyển hướng tới root nếu ng dùng hiện tại ko phải là user mà mình đã đăng nhập
    redirect_to(root_url) unless @user == current_user
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end
