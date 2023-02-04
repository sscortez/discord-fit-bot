# frozen_string_literal: true

class RegisteredUser < ApplicationRecord
  belongs_to :user
  belongs_to :guild

  validates :uuid, presence: true
  validates :user, uniqueness: { scope: :guild_id }
end
