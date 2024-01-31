# frozen_string_literal: true

# Module SessionHelper
module SessionsHelper
  def logged_in?
    !current_user.nil?
  end

  def current_user?(user)
    user && user == current_user
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless @user == current_user
  end

  def comment_owner
    @comment = Micropost.find_by(id: params[:id])
    @user = @comment.user
    redirect_to(root_url) unless @user == current_user
  end

  def render_reaction_icon(action_type)
    case action_type
    when 'like' || 0
      image_tag('like.svg', class: 'icon transition ease-in-out delay-150 hover:-translate-y-1 hover:scale-110 duration-300')
    when 'love' || 1
      image_tag('love.svg', class: 'icon transition ease-in-out delay-150 hover:-translate-y-1 hover:scale-110 duration-300')
    when 'haha' || 2
      image_tag('haha.svg', class: 'icon transition ease-in-out delay-150 hover:-translate-y-1 hover:scale-110 duration-300')
    when 'wow' || 3
      image_tag('wow.svg', class: 'icon transition ease-in-out delay-150 hover:-translate-y-1 hover:scale-110 duration-300')
    when 'sad' || 4
      image_tag('sad.svg', class: 'icon transition ease-in-out delay-150 hover:-translate-y-1 hover:scale-110 duration-300')
    when 'angry' || 5
      image_tag('angry.svg', class: 'icon transition ease-in-out delay-150 hover:-translate-y-1 hover:scale-110 duration-300')
    end
  end

  def render_omniauth_icon(action_type)
    case action_type
    when 'GitHub'
      image_tag('icons8-github.svg', class: 'icon_omniauth transition ease-in-out delay-150')
    when 'Facebook'
      image_tag('icons8-facebook.svg', class: 'icon_omniauth transition ease-in-out delay-150')
    when 'GoogleOauth2'
      image_tag('icons8-google.svg', class: 'icon_omniauth transition ease-in-out delay-150')
    end
  end
end
