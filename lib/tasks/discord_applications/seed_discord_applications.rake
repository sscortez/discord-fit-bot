# frozen_string_literal: true

require 'discord_client'

namespace :discord_applications do
  desc 'Seeds discord_applications table'
  task seed_discord_applications: :environment do
    DiscordApplication.destroy_all

    [
      ENV.fetch('FITBOT_APPLICATION_ID'),
      ENV.fetch('TESTAPP_APPLICATION_ID')
    ].each do |app|
      client = DiscordClient.new(app)

      response_body = client.get_application.body

      DiscordApplication.create!(
        discord_application_id: response_body['id'],
        name: response_body['name'],
        meta_data: response_body
      )
    end
  end
end
