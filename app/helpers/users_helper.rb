# frozen_string_literal: true

# Module UserHelper
module UsersHelper
  def gravatar_for(user, options = { size: 160 })
    size = options[:size]
    return unless user.email

    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size} "
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

  def correct_user?
    @micropost = Micropost.find_by(id: params[:id])
    @user = @micropost.user
    redirect_to(root_url) unless @user == current_user
  end
end
