# frozen_string_literal: true

##
# Seeds tables for development and testing environments

class DevelopmentAndTestSeeder
  def call
    seed_application_command_types
    seed_discord_applications
  end

  def seed_application_command_types
    invoke_rake_task('discord_applications:seed_application_command_types')
  end

  def seed_discord_applications
    invoke_rake_task('discord_applications:seed_discord_applications')
  end

  private

  def invoke_rake_task(task_name)
    Rake::Task[task_name].invoke
  end
end
