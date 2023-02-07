# frozen_string_literal: true

require 'securerandom'

FactoryBot.define do
  factory :registered_user do
    user
    guild

    uuid { SecureRandom.uuid }
  end
end
