# frozen_string_literal: true

FactoryBot.define do
  factory :individual_workout do
    registered_user

    workout_date  { Time.zone.today }
    month_year    { '07-2023' }
    duration_mins { 15 }
  end
end
