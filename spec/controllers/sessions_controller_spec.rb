# spec/controllers/devise/sessions_controller_spec.rb
require 'rails_helper'

RSpec.describe Devise::SessionsController, type: :controller do
  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template('devise/sessions/new')
    end
  end

  describe 'POST #create' do
    let(:user) { FactoryBot.create(:user) }

    context 'with valid credentials' do
      it 'redirects to the root path' do
        post :create, params: { user: { email: user.email, password: user.password } }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid credentials' do
      it 'does not sign in the user' do
        post :create, params: { user: { email: user.email, password: 'wrong_password' } }
        expect(subject.current_user).to be_nil
      end

      it 'renders the new template' do
        post :create, params: { user: { email: user.email, password: 'wrong_password' } }
        expect(response).to render_template('devise/sessions/new')
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:user) { FactoryBot.create(:user) }

    it 'signs out the user' do
      sign_in user
      delete :destroy
      expect(subject.current_user).to be_nil
    end

    it 'redirects to the root path' do
      sign_in user
      delete :destroy
      expect(response).to redirect_to(root_path)
    end
  end
end
