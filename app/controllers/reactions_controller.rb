# frozen_string_literal: true

# Controller Reactions
class ReactionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @existing_reaction = current_user.reactions.find_by(micropost_id: params[:mic_id])
    if @existing_reaction
      respond_to do |format|
        if @existing_reaction.action == params[:action_type]
          @existing_reaction.destroy
          format.js { render template: 'reactions/destroy' }
        else
          @existing_reaction.update_attribute(:action, params[:action_type])
          format.js { render template: 'reactions/update' }
        end
      end
    else
      respond_to do |format|
        @reaction = current_user.reactions.build(micropost_id: params[:mic_id], action: params[:action_type])
        return unless @reaction.save

        format.js
      end

    end
  end
end
