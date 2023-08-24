# frozen_string_literal: true

require 'discord_client'

module IndividualChallenges
  class AddIndividualChallenge
    def initialize(registered_user_id, challenge_date, monthly_goal_count)
      @registered_user_id = registered_user_id
      @challenge_date     = challenge_date
      @monthly_goal_count = monthly_goal_count
    end

    def call
      create_individual_challenge!(@registered_user_id, @monthly_goal_count, @challenge_date)
    end

    def create_individual_challenge!(registered_user_id, monthly_goal_count, challenge_date)
      IndividualChallenge.create!(
        registered_user_id:,
        monthly_goal_count:,
        challenge_date:,
        month_year: challenge_date.present? ? challenge_date.strftime('%m-%Y') : ''
      )
    end
  end
end
