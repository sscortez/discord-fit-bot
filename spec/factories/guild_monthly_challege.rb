# frozen_string_literal: true

FactoryBot.define do
  factory :guild_monthly_challenge do
    guild

    month_year       { DateTime.parse('02/01/2023').to_date }
    target_exercises { rand(1..50) }
    active           { true }
  end
end
