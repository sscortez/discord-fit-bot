module Ping
  extend Discordrb::Commands::CommandContainer

  DiscordBot.message(content: "Ping!") do |event|
    event.respond("Message!")
  end

  DiscordBot.command(:ping) do |event|
    event.respond("Pong!")
  end

  DiscordBot.command(:pong) do |event|
    event.respond("Ping!")
  end
end
