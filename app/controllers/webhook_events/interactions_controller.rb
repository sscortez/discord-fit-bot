# frozen_string_literal: true

module WebhookEvents
  class InteractionsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def create
      validator = Interactions::WebhookValidator.new(request, fitbot_public_key: ENV.fetch('TESTAPP_PUBLIC_KEY'))
      result = validator.call
      request.body.rewind
      body = JSON.load(request.body.read)

      if result
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
      else
        render status: :unauthorized, json: { error: 'Invalid request signature' }
      end
    end
  end
end
