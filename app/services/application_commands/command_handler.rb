# frozen_string_literal: true

module ApplicationCommands
  class CommandHandler
    APP_COMMANDS = {
      'register'   => ApplicationCommands::Register,
      'unregister' => ApplicationCommands::Unregister
    }.freeze

    def initialize(request_body)
      @request_body = request_body
    end

    def call
      command = APP_COMMANDS.fetch(requested_command)

      command&.new(@request_body)&.call
    end

    private

    def requested_command
      @request_body['data']['name']
    end

    def dummy_method
      1
    end
  end
end
