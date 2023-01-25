# frozen_string_literal: true

module Ping
  extend Discordrb::Commands::CommandContainer

  DiscordBot.command(:test) do |event|
    event.respond("Username: #{event.author.username}")
    event.respond("User ID: #{event.author.id}")
    event.respond("Channel: #{event.channel}")
    event.respond("Channel: #{event.channel.to_json}")
    event.respond("Server: #{event.server}")
  end

  DiscordBot.command(:ping) do |event|
    event.respond('Pong!')
  end

  DiscordBot.command(:pong) do |event|
    event.respond('Ping!')
  end
end
