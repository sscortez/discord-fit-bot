# frozen_string_literal: true

module Interactions
  class RequestHandler
    RequestOutput = Struct.new(:type, :output)

    def initialize(request_body)
      @request_body = request_body
    end

    def call
      case request_type
      when 1
        RequestOutput.new(1, true)
      when 2
        RequestOutput.new(4, ApplicationCommands::CommandHandler.new(@request_body).call)
      end
    end

    private

    def request_type
      @request_body['type']
    end
  end
end
