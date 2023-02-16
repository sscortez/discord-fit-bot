# frozen_string_literal: true

class ApplicationCommandType < ApplicationRecord
  has_many :application_commands, dependent: nil

  validates :name, :description, presence: true
end
