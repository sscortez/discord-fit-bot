# frozen_string_literal: true

class IndividualChallenge < ApplicationRecord
  belongs_to :registered_user, dependent: nil

  validates :monthly_goal_count, :date, presence: true

  validates :month_year,
            format: {
              with: /(0?[1-9]|1[012])-\d{4}/,
              message: I18n.t('month_year_validation_message')
            },
            presence: true
end
