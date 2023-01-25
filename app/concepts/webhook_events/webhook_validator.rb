# frozen_string_literal: true

module WebhookEvents
  class WebhookValidator
    def initialize(request, options = {})
      @request    = request
      @public_key = options['FITBOT_PUBLIC_KEY'].presence || ENV.fetch('FITBOT_PUBLIC_KEY')
    end

    def call
      verify_request
    end

    private

    def verify_request
      verify_key.verify([signature].pack('H*'), "#{timestamp}#{body}")
    end

    def signature
      @request.headers['X-Signature-Ed25519']
    end

    def timestamp
      @request.headers['X-Signature-Timestamp']
    end

    def body
      data ||= @request.body.read

      @request.body.rewind

      data
    end

    def verify_key
      Ed25519::VerifyKey.new([@public_key].pack('H*'))
    end
  end
end
