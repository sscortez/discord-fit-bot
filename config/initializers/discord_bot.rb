require 'discordrb'

DiscordBot = Discordrb::Commands::CommandBot.new(
  token: ENV.fetch("FITBOT_TOKEN"),
  client_id: ENV.fetch("FITBOT_CLIENT_ID"),
  prefix: "/"
)

Dir["#{Rails.root}/app/commands/*.rb"].each { |file| require file }

puts " This is the invite url: #{DiscordBot.invite_url}"

DiscordBot.run("true")
