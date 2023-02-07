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

<<<<<<< HEAD
<<<<<<< HEAD
      command&.new(@request_body)&.call
=======
      command&.new(@reqeust_body)&.call
>>>>>>> a69aeac (Added command handler to distribute command requests. Updated tables. Updated tests to be more detailed)
=======
      command&.new(@request_body)&.call
>>>>>>> ed023c3 (Finished adding /register command)
    end

    private

    def requested_command
      @request_body['data']['name']
    end
  end
end
