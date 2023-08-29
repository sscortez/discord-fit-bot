# frozen_string_literal: true

FactoryBot.define do
  factory :individual_challenge do
    registered_user

    challenge_date     { Time.zone.today }
    month_year         { '07-2023' }
    monthly_goal_count { 5 }
  end
end
