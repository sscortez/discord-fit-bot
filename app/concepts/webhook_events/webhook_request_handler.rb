# frozen_string_literal: true

module WebhookEvents
  ##
  # Distributes request to its respective
  # services
  class WebhookRequestHandler
    def initialize(request)
      @request = request
    end

    ##
    # Stores request data

    def call
      WebhookEvents::WebhookWorker.perform_async(@request)
    end
  end
end
