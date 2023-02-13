# frozen_string_literal: true

class ApplicationCommand < ApplicationRecord
  belongs_to :discord_application
  belongs_to :application_command_type

  validates :name, :meta_data, presence: true
  validates :discord_application_command_id, presence: true, uniqueness: true
end
