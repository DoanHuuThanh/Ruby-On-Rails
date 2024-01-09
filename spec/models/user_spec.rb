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

  describe 'POST #create' do
    let(:user) { create(:user, activated: true) } # Assuming you have a FactoryBot factory for User

    context 'with valid credentials' do
      it 'redirects to the root path' do
        post :create, params: { session: { email: user.email, password: '123' } }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid credentials' do
      it 'renders the new template' do
        post :create, params: { session: { email: 'invalid@example.com', password: 'wrong_password' } }
        expect(response).to render_template(:new)
      end

      it 'sets a flash message' do
        post :create, params: { session: { email: 'invalid@example.com', password: 'wrong_password' } }
        expect(flash[:danger]).to be_present
      end
    end

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
                                                                             'image' => 'https://lh4.googleusercontent.com/photo.jpg',
                                                                             'urls' => {
                                                                               'google' => 'https://plus.google.com/+JohnSmith'
                                                                             }
                                                                           },
                                                                           'credentials' => {
                                                                             'token' => 'TOKEN',
                                                                             'refresh_token' => 'REFRESH_TOKEN',
                                                                             'expires_at' => 1_496_120_719,
                                                                             'expires' => true
                                                                           },
                                                                           'extra' => {
                                                                             'id_token' => 'ID_TOKEN',
                                                                             'id_info' => {
                                                                               'azp' => 'APP_ID',
                                                                               'aud' => 'APP_ID',
                                                                               'sub' => '100000000000000000000',
                                                                               'email' => 'john@example.com',
                                                                               'email_verified' => true,
                                                                               'at_hash' => 'HK6E_P6Dh8Y93mRNtsDB1Q',
                                                                               'iss' => 'accounts.google.com',
                                                                               'iat' => 1_496_117_119,
                                                                               'exp' => 1_496_120_719
                                                                             },
                                                                             'raw_info' => {
                                                                               'sub' => '100000000000000000000',
                                                                               'name' => 'John Smith',
                                                                               'given_name' => 'John',
                                                                               'family_name' => 'Smith',
                                                                               'profile' => 'https://plus.google.com/+JohnSmith',
                                                                               'picture' => 'https://lh4.googleusercontent.com/photo.jpg?sz=50',
                                                                               'email' => 'john@example.com',
                                                                               'email_verified' => 'true',
                                                                               'locale' => 'en',
                                                                               'hd' => 'company.com'
                                                                             }
                                                                           }
                                                                         })

      get :login_with_third_party

      expect(response).to redirect_to(root_path)
    end
  end
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
