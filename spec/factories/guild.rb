# frozen_string_literal: true

FactoryBot.define do
  factory :guild do
    sequence(:discord_guild_id) { |n| "some_discord_guild_id_#{n}" }

    name      { 'some_name' }
    meta_data { { 'some_key' => 'some_value' } }
  end
end
