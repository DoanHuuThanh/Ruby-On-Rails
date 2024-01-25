# spec/controllers/registrations_controller_spec.rb

require 'rails_helper'

RSpec.describe Devise::RegistrationsController, type: :controller do
  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  describe 'GET #new' do
    it 'renders the new registration page' do
      get :new
      expect(response).to render_template(:new)
    end
  end

    context 'with invalid parameters' do
      it 'does not create a new user' do
        expect {
          post :create, params: { user: attributes_for(:user, email: nil) }
        }.not_to change(User, :count)
      end

      it 're-renders the new registration page' do
        post :create, params: { user: attributes_for(:user, email: nil) }
        expect(response).to render_template(:new)
      end
    end
  end
end
