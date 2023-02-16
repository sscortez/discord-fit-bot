# frozen_string_literal: true

FactoryBot.define do
  factory :discord_application do
    sequence(:discord_application_id) { |n| "some_discord_application_id_#{n}" }

    name      { 'some_discord_application_name' }
    meta_data { { 'some_key' => 'some_value' } }
  end
end
