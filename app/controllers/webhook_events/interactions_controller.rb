# frozen_string_literal: true

module WebhookEvents
  class InteractionsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def test
      # puts 'The test method has been successfully called'

      validator = WebhookEvents::WebhookValidator.new(request)
      validator.call

      render json: { type: 1 }
    end
  end
end
