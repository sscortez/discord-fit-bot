# frozen_string_literal: true

require 'discord_client'

namespace :discord_applications do
  desc 'Seeds application_commands table with commands that each records in the discord_applications table have'
  task seed_application_commands: :environment do
    ApplicationCommand.destroy_all

    app_ids = [ENV.fetch('FITBOT_APPLICATION_ID'), ENV.fetch('TESTAPP_APPLICATION_ID')]

    app_ids.each do |app|
      client = DiscordClient.new(app)

      response_body = client.get_application_commands.body

      response_body.each do |command|
        ApplicationCommand.create!(
          discord_application:            DiscordApplication.find_by(discord_application_id: command['application_id']),
          application_command_type:       ApplicationCommandType.find(command['type'].to_i),
          discord_application_command_id: command['id'],
          name:                           command['name'],
          meta_data:                      command
        )
      end
    end
  end
end
