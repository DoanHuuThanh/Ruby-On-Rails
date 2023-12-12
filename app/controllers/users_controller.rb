class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index] # trc khi thực hiện các hành động edit,update trong controller,
                                                        # hãy gọi phương thức logged_in_user
  before_action :correct_user, only: [:edit, :update]
  def index
    @user = User.all
  end
  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
  end
  def edit
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

  def update
       @user = User.find(params[:id])
       if @user.update(user_params)
             flash[:success] = "User updated successfully"
             redirect_to @user
        else
          render 'edit'
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


  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
    end


end
