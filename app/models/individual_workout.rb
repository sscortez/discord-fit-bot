# frozen_string_literal: true

class IndividualWorkout < ApplicationRecord
  belongs_to :registered_user, dependent: nil

  validates :duration_mins, :workout_date, presence: true

  validates :month_year,
            format: {
              with: /(0?[1-9]|1[012])-\d{4}/,
              message: I18n.t('month_year_validation_message')
            },
            presence: true
end
