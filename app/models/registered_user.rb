# frozen_string_literal: true

class RegisteredUser < ApplicationRecord
  belongs_to :user
  belongs_to :guild

  has_many :individual_challenges, dependent: nil
  has_many :individual_workouts,   dependent: nil

  validates :uuid, presence: true
  validates :user, uniqueness: { scope: :guild_id }
end
