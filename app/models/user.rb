# frozen_string_literal: true

class User < ApplicationRecord
  has_many :registered_users, dependent: nil
  has_many :guilds, through: :registered_users

  validates :username, :meta_data, presence: true
  validates :discord_user_id, presence: true, uniqueness: true
end
