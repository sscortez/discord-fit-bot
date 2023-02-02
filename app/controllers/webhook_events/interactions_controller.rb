# frozen_string_literal: true

module WebhookEvents
  class InteractionsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      validator = Interactions::WebhookValidator.new(request, public_key: ENV.fetch('TESTAPP_PUBLIC_KEY'))
      result = validator.call

      if result
        # handle request
        # Is request this or that, then ingest it as such
        # Forward response based on command
        WebhookEvents::WebhookRequestHandler.new(result).call
      else
        render status: :unauthorized, json: { error: 'Invalid request signature' }
      end
    end

    def handle_application_commands
      type = body['type']
      case type
      when 1
        render json: { type: 1 }
      when 2
        response = {
          type: 4,
          data: {
            content: 'Hello World!'
          }
        }
        render json: response
      end
    end
  end
end
