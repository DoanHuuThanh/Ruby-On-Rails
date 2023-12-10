class User < ApplicationRecord
  before_save {self.email == email.downcase } #before_save được sử dụng để thiết lập một hành động hoặc biểu thức được thực thi
                                              #trước khi đối tượng được lưu vào cơ sở dữ liệu.
  validates :name,  presence: true, length: {maximum:200}
  validates :email, presence: true, length: {maximum:200, minium:6}, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},uniqueness: {case_sensitive: false}
  #uniqueness la duy nhat ko duoc trung lap,case_sensitive: false mang ý nghĩa ko phân biệt in hoa in thường
  has_secure_password
  #khi bạn sử dụng has_secure_password trong model, bạn có thể sử dụng cặp thuộc
  #tính password và password_confirmation để xác nhận mật khẩu người dùng khi tạo hoặc cập nhật tài khoản.
  validates :password, presence: true, length: {maximum:30}
  #tự thêm phương thức authenticate để xác thực ng dùng user.authenticate
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end


end
