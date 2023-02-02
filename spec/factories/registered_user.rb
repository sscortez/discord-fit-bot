# frozen_string_literal: true

FactoryBot.define do
  factory :registered_user do
    user
    guild
  end
end
