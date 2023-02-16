# frozen_string_literal: true

namespace :discord_applications do
  desc 'Seeds application_command_types table'
  task seed_application_command_types: :environment do
    ApplicationCommandType.destroy_all

    ApplicationCommandType.create!(
      id: 1,
      name: 'CHAT_INPUT',
      description: 'Slash commands; a text-based command that shows up when a user types /'
    )

    ApplicationCommandType.create!(
      id: 2,
      name: 'USER',
      description: 'A UI-based command that shows up when you right click or tap on a user'
    )

    ApplicationCommandType.create!(
      id: 3,
      name: 'MESSAGE',
      description: 'A UI-based command that shows up when you right click or tap on a message'
    )
  end
end
