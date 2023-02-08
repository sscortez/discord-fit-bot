# frozen_string_literal: true

module WebhookEvents
  class WebhookValidator
    ValidatedRequest = Struct.new(:id, :type, :body)

    def initialize(request, options = {})
      @request = request
      @options = options
    end

    # @abstract Subclass is expected to implement #call
    # @!method call
    #    Make a particular model of world class vehicle

    # @abstract Subclass is expected to implement #verify_request
    # @!method verify_request
    #    Make a particular model of world class vehicle
  end
end
