# frozen_string_literal: true

require 'discord_client'

module Commands
  COMMAND_TYPES = {
    CHAT_INPUT: 1,
    USER:       2,
    MESSAGE:    3
  }.freeze

  COMMAND_OPTION_TYPES = {
    SUB_COMMAND:       1,
    SUB_COMMAND_GROUP: 2,
    STRING:            3,
    INTEGER:           4,
    BOOLEAN:           5,
    USER:              6,
    CHANNEL:           7,
    ROLE:              8,
    MENTIONABLE:       9,
    NUMBER:            10,
    ATTACHMENT:        11
  }.freeze

  class Create
    def initialize(name, type, description, options = {})
      @name        = name
      @type        = COMMAND_TYPES[type.upcase]
      @description = description
      @options     = options['options'].presence || nil
      @client      = DiscordClient.new
    end

    def call
      'This method has been called'
    end

    def body
      body = {
        'name' => @name,
        'type' => @type,
        'description' => @description
      }

      return body unless @options

      body.update('options' => @options)
    end
  end
end
