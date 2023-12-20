class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token
  has_many :microposts, dependent: :destroy #nếu ng dùng bị xóa thì những microposts cx bị xóa
  has_many :active_relationships, class_name: "Relationship",foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  before_save :downcase_email #before_save được sử dụng để thiết lập một hành động hoặc biểu thức được thực thi
                                              #trước khi đối tượng được lưu vào cơ sở dữ liệu.
  before_create :create_activation_digest
  before_create :default_activated
  #Dòng mã này nói rằng khi một đối tượng User mới được tạo và lưu vào cơ sở dữ liệu, Rails sẽ tự động gọi phương thức create_activation_digest trước khi thực hiện lưu trữ (create).

  validates :name,  presence: true, length: {maximum:200}
  validates :email, presence: true, length: {maximum:200, minium:6}, format: {with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i},uniqueness: {case_sensitive: false}
  #uniqueness la duy nhat ko duoc trung lap,case_sensitive: false mang ý nghĩa ko phân biệt in hoa in thường
  has_secure_password
  validates :password, presence: true, length: {maximum:200, minium:3}, allow_nil: true
  #khi bạn sử dụng has_secure_password trong model, bạn có thể sử dụng cặp thuộc
  #tính password và password_confirmation để xác nhận mật khẩu người dùng khi tạo hoặc cập nhật tài khoản.
  #tự thêm phương thức authenticate để xác thực ng dùng user.authenticate

   #mã hóa
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

   #sẽ trả về một chuỗi ngẫu nhiên được mã hóa theo Base64
  def User.new_token
    SecureRandom.urlsafe_base64
  end

   # lưu trữ và khởi tạo cho remember_digest
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token));
    #update_attribute trong Rails được sử dụng để cập nhật một thuộc tính duy nhất của đối tượng và lưu trực tiếp vào cơ sở dữ liệu.
  #Cụ thể, nó sẽ thay đổi giá trị của thuộc tính được chỉ định, sau đó lưu lại đối tượng vào cơ sở dữ liệu.
  end

   #xác thực remember_digest đc lưu có bằng remember_token đc lưu trong cookies
  def authenticated?(attribute,remember_token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
  BCrypt::Password.new(digest).is_password?(remember_token)
  end

   # khởi tạo lại giá trị remember_digest về nil khi logout
  def forget
    update_attribute(:remember_digest, nil)
  end

   #chuyển email thành chữ thg
  def downcase_email
    self.email = email.downcase
  end
  def default_activated
      self.activated = false
  end

  def create_activation_digest
    self.activation_token =  User.new_token
    self.activation_digest = User.digest(activation_token)
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at,Time.zone.now)
  end

  def send_activation_email
       UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
      self.reset_token = User.new_token
      update_attribute(:reset_digest, User.digest(reset_token))
      update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
       UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    self.reset_sent_at < 2.hours.ago #ktra matkhau cap nhap luc trc co vuot qua 2 tieng trc hien tai
    end

    def feed
      following_ids = "SELECT followed_id FROM relationships
      WHERE follower_id = :user_id"
      Micropost.where("user_id IN (#{following_ids})
      OR user_id = :user_id", user_id: id)
      end

     def follow(other_user)
        following << other_user
     end

    def unfollow(other_user)
       following.delete(other_user)
    end

    def following?(other_user)
       following.include?(other_user)
    end

    def self.from_omniauth(auth)
      password = User.new_token
      where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.password = User.digest(password)
        user.email = auth.info.email
        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)
        user.save!
      end
    end
end
