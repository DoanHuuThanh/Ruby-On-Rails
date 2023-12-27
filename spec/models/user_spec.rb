# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'should have a valid factory' do
    user = create(:user)
    expect(user).to be_valid
  end
end

RSpec.describe SessionsController, type: :controller do
  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end
end

RSpec.describe SessionsController, type: :controller do
  describe 'DELETE #destroy' do
    it 'logs out the user' do
      delete :destroy
      expect(controller.logged_in?).to be_falsy
    end

    it 'redirects to the login path' do
      delete :destroy
      expect(response).to redirect_to(login_path)
    end
  end
end

RSpec.describe SessionsController, type: :controller do
  context 'when the user is not activated' do
    it 'sets a flash message' do
      user.update(activated: false)
      post :create, params: { session: { email: user.email, password: '123' } }
      expect(flash[:warning]).to be_present
    end

    it 'redirects to the root path' do
      user.update(activated: false)
      post :create, params: { session: { email: user.email, password: '123' } }
      expect(response).to redirect_to(root_path)
    end
  end
end

RSpec.describe SessionsController, type: :controller do
  describe 'GET #login_with_google' do
    it 'logs in the user with Google authentication' do
      # Stub the authentication hash that would be returned by OmniAuth
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
                                                                           'provider' => 'google_oauth2',
                                                                           'uid' => '100000000000000000000',
                                                                           'info' => {
                                                                             'name' => 'John Smith',
                                                                             'email' => 'john@example.com',
                                                                             'first_name' => 'John',
                                                                             'last_name' => 'Smith',
                                                                             'image' => 'https://lh4.googleusercontent.com/photo.jpg'
                                                                           },
                                                                           'credentials' => {
                                                                             'token' => 'TOKEN',
                                                                             'refresh_token' => 'REFRESH_TOKEN',
                                                                             'expires_at' => 1_496_120_719,
                                                                             'expires' => true
                                                                           }
                                                                         })
      get :login_with_third_party
      expect(response).to redirect_to(root_path)
    end
  end
end
