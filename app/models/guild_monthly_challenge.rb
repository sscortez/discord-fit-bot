# frozen_string_literal: true

class GuildMonthlyChallenge < ApplicationRecord
  belongs_to :guild, dependent: nil

  validates :target_exercises, :active, presence: true

  validates :month_year,
            format: {
              with: /(0?[1-9]|1[012])-\d{4}/,
              message: I18n.t('month_year_validation_message')
            },
            presence: true
end
