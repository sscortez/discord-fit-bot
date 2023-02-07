# frozen_string_literal: true

module Interactions
  class RequestHandler
    REQUEST_TYPES = {
      2 => ApplicationCommands::CommandHandler
    }.freeze

    def initialize(request_body)
      @request_body = request_body
    end

    def call
      handler = REQUEST_TYPES.fetch(request_type)

      handler&.new(@request_body)&.call
    end

    private

    def request_type
      @request_body['type']
    end
  end
end
