# frozen_string_literal: true

require 'securerandom'

FactoryBot.define do
  factory :application_command do
    discord_application
    application_command_type

    sequence(:discord_application_command_id) { |n| "some_discord_application_command_id_#{n}" }

    name { 'some_application_command_name' }
    meta_data { { 'some_key' => 'some_value' } }
  end
end
