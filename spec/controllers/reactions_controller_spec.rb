# frozen_string_literal: true

# spec/controllers/reactions_controller_spec.rb

require 'rails_helper'

RSpec.describe ReactionsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:micropost) { FactoryBot.create(:micropost, user:) }
  before { log_in(user) }

  describe 'POST #create' do
    context 'when existing reaction is present' do
      let(:existing_reaction) { FactoryBot.create(:reaction, micropost:) }

      context 'with matching action_type' do
        it 'destroys the existing reaction' do
          post :create, format: :js, params: { mic_id: micropost.id, action_type: existing_reaction.action }
          expect(response).to have_http_status(:success)
        end
      end

      context 'with different action_type' do
        it 'updates the existing reaction' do
          post :create, format: :js, params: { mic_id: micropost.id, action_type: 'like' }
          existing_reaction.reload
          expect(response).to have_http_status(:success)
        end
      end
    end

    context 'when no existing reaction is present' do
      it 'creates a new reaction' do
        post :create, format: :js, params: { mic_id: micropost.id, action_type: 'like' }
        expect(user.reactions.count).to eq(1)
        expect(response).to render_template('reactions/create')
      end
    end
  end
end
