# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:micropost) { FactoryBot.create(:micropost, user:) }
  before { log_in(user) }

  describe 'comment' do
    let(:micropost_with_parent) { FactoryBot.create(:micropost, :with_parent, user:) }
    it 'create  comment' do
      post :create, format: :js, params: { micropost: { micropost_id: micropost.id, parent_id: micropost.id, content: Faker::Lorem.sentence } }
      expect(response).to render_template(:create)
      expect(response).to have_http_status(:success)
    end

    it 'edit comment' do
      patch :update, format: :js, params: { id: micropost_with_parent.id, micropost: { content: Faker::Lorem.sentence } }
      expect(response).to render_template(:update)
      expect(response).to have_http_status(:success)
    end

    it 'destroys comment asynchronously', js: true do
      micropost = FactoryBot.create(:micropost, :with_parent, user:)
      expect do
        delete :destroy, format: :js, params: { id: micropost.id }
      end.to change(Micropost, :count).by(-1)
      expect(response).to render_template(:destroy)
      expect(response).to have_http_status(:success)
    end
  end
end
