# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:micropost) { FactoryBot.create(:micropost, user:) }
  before { log_in(user) }

  describe 'comment' do
    let(:micropost_with_parent) { FactoryBot.create(:micropost_with_parent, user:) }
    it 'create  comment' do
      post :create_comment, params: { micropost_id: micropost.id, parent_id: micropost.id, micropost: { content: Faker::Lorem.sentence } }
      expect(response).to redirect_to(root_path)
      expect(flash[:success]).to eq('Comment created!')
    end

    it 'edit comment' do
      patch :update, params: { id: micropost_with_parent.id, micropost_id: micropost_with_parent.parent_id, micropost: { content: Faker::Lorem.sentence } }
      expect(response).to redirect_to(root_path)
      expect(flash[:success]).to eq('Comment updated!')
    end

    it 'destroys comment asynchronously', js: true do
      micropost = FactoryBot.create(:micropost_with_parent, user: user)
      expect do
        delete :destroy, format: :js, params: { id: micropost.id }
      end.to change(Micropost, :count).by(-1)
      expect(response).to render_template(:destroy)
      expect(response).to have_http_status(:success)
    end
  end
end
