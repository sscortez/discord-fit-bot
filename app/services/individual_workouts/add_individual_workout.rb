# frozen_string_literal: true

require 'discord_client'

module IndividualWorkouts
  class AddIndividualWorkout
    def initialize(registered_user_id, workout_date, duration_mins)
      @registered_user_id = registered_user_id
      @workout_date       = workout_date
      @duration_mins      = duration_mins
    end

    def call
      create_individual_workout!(@registered_user_id, @duration_mins, @workout_date)
    end

    def create_individual_workout!(registered_user_id, duration_mins, workout_date)
      IndividualWorkout.create!(
        registered_user_id:,
        duration_mins:,
        workout_date:,
        month_year: workout_date.present? ? workout_date.strftime('%m-%Y') : ''
      )
    end
  end
end
