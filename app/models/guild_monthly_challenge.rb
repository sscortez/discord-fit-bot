# frozen_string_literal: true

class GuildMonthlyChallenge < ApplicationRecord
  has_many :guilds, dependent: nil

  validates :month_year, :target_exercises, :active, presence: true
end
