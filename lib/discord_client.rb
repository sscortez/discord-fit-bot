# frozen_string_literal: true

require 'faraday'

class DiscordClient
  def initialize(options = {})
    @bot_token      = options['bot_token'].presence      || ENV.fetch('FITBOT_TOKEN')
    @application_id = options['application_id'].presence || ENV.fetch('FITBOT_APPLICATION_ID')
    @base_url       = options['base_url'].presence       || ENV.fetch('DISCORD_BASE_URL')
    @adapter        = options['adapter'].presence        || Faraday.default_adapter

    # TO DO: Figure out what the credentials_token is
    @my_credentials_token = nil
  end

  def create_a_test_fit_bot_command
    url = "/applications/#{@application_id}/commands"
    body = {
      name:         'test_fit_bot',
      type:         1,
      description:  "A simple slash command. Returns 'Hello World!'",
      autocomplete: true
    }

    connection.post(url) do |conn|
      conn.body = body
    end
  end

  def create_a_command(body, auth_type)
    connection.post do |con|
      con.body = body

      case auth_type
      when 'bot'
        con.headers Authorization: "Bot #{@bot_token}"
      when 'app'
        con.headers Authorization: "Bearer #{@my_credentials_token}"
      end
    end
  end

  def connection
    Faraday.new do |conn|
      conn.url_prefix = @base_url
      conn.request :json
      conn.response :json, content_type: 'application/json'
      conn.adapter @adapter
    end
  end
end
