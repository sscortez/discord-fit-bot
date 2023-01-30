# frozen_string_literal: true

module Interactions
  class WebhookValidator < WebhookEvents::WebhookValidator

    attr_reader :data

    def initialize(request, options = {})
      @request    = request
      @public_key = options[:public_key].presence || ENV.fetch('FITBOT_PUBLIC_KEY')
      @data       = nil
    end

    def call
      verify_request

      ValidatedRequest.new(@body['id'], 'interaction', @body)
    rescue Ed25519::VerifyError
      false
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
      @data ||= @request.body.read

      @request.body.rewind

      @data
    end

    def verify_key
      Ed25519::VerifyKey.new([@public_key].pack('H*'))
    end
  end
end
