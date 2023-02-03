# frozen_string_literal: true

class User < ApplicationRecord
  has_many :registered_users, dependent: nil
  has_many :guilds, through: :registered_users

  validates :discord_user_id, :username, :meta_data, presence: true
end
