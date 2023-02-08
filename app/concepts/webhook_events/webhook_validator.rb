# frozen_string_literal: true

module WebhookEvents
  class WebhookValidator
    ValidatedRequest = Struct.new(:id, :type, :body)

    def initialize(request, options = {})
      @request = request
      @options = options

      case @request['application_id']
      when ENV.fetch('TESTAPP_APPLICATION_ID')
        @public_key = ENV.fetch('TESTAPP_PUBLIC_KEY')
      when ENV.fetch('FITBOT_APPLICATION_ID')
        @public_key = ENV.fetch('FITBOT_PUBLIC_KEY')
      end
    end

    # @abstract Subclass is expected to implement #call
    # @!method call
    #    Make a particular model of world class vehicle

    # @abstract Subclass is expected to implement #verify_request
    # @!method verify_request
    #    Make a particular model of world class vehicle
  end
end
