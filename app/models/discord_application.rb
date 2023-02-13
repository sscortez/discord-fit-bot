# frozen_string_literal: true

class DiscordApplication < ApplicationRecord
  has_many :application_commands, dependent: nil

  validates :name, :meta_data, presence: true
  validates :discord_application_id, presence: true, uniqueness: true
end
