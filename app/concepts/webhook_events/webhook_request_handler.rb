# frozen_string_literal: true

module WebhookEvents
  class WebhookRequestHandler
    def initialize(request)
      @request = request
    end

    def call
      WebhookEvents::WebhookWorker.perform_async(@request)
    end

    private
  end
end
