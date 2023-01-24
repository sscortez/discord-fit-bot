# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    discord_id { 'some_discord_id' }
    discord_name { 'some_discord_name' }
  end
end
