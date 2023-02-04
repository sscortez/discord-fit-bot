# frozen_string_literal: true

module ApplicationCommands
  class CommandHandler
    APP_COMMANDS = {
      'register' => ApplicationCommands::Register::Register
    }.freeze

    def initialize(request_body)
      @request_body = request_body
    end

    def call
      command = APP_COMMANDS.fetch(requested_command)

      command&.new(@reqeust_body)&.call
    end

    private

    def requested_command
      @request_body['data']['name']
    end
  end
end
