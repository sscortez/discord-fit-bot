# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:discord_user_id) { |n| "some_discord_user_id_#{n}" }

    username  { 'some_username' }
    meta_data { { 'some_key' => 'some_value' } }
  end
end
