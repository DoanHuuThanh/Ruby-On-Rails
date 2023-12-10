class UsersController < ApplicationController
  def index
    @user = User.all
  end
  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      reset_session # đầu tiên phải để sesion trở về rỗng ko có j cả
      log_in @user # tạo và đăng nhập luôn bằng tài khoản vừa tạo
        flash[:success] = "User created successfully"
        redirect_to @user
     else
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
    #params.require(:user): Phương thức require đảm bảo rằng trong params, có một tham số tên là :user tồn tại.
    #Nếu không, nó sẽ ném một ngoại lệ (ActionController::ParameterMissing).
    #.permit(:name, :email, :password, :password_confirmation): Phương thức permit xác định danh sách các tham số mà bạn
    #cho phép được chấp nhận trong hash params[:user]. Nếu một tham số không nằm trong danh sách này, nó sẽ bị loại bỏ.
  end

end
