# frozen_string_literal: true

module WebhookEvents
  class InteractionsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def index
      render json: { type: 1 }
    end

    def create
      request

      validator = Interactions::WebhookValidator.new(request, public_key: ENV.fetch('FITBOT_PUBLIC_KEY'))
      result = validator.call

      if result
        response = Interactions::RequestHandler.new(result.body).call

        if response.type == 1
          render json: { type: response.type }
        else
          render json: { type: response.type, data: { content: response.output } }
        end
      else
        render status: :unauthorized, json: { error: 'Invalid request signature' }
      end
    end
  end
end
