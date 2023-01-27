# frozen_string_literal: true

module WebhookEvents
  class InteractionsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      validator = Interactions::WebhookValidator.new(request)
      result = validator.call

      if result
        result.data
        render json: { type: 1 }
      else
        render status: :unauthorized, json: { error: 'Invalid request signature' }
      end
    end
  end
end
