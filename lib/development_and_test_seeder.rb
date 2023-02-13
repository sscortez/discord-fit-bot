# frozen_string_literal: true

##
# Seeds tables for development and testing environments

class DevelopmentAndTestSeeder
  def call
    seed_application_command_types
  end

  def seed_application_command_types
    invoke_rake_task('discord_applications:seed_application_command_types')
  end

  private

  def invoke_rake_task(task_name)
    Rake::Task[task_name].invoke
  end
end
