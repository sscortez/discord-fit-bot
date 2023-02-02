# frozen_string_literal: true

class User < ApplicationRecord
  has_many :registered_users
  has_many :guilds, through: :registered_users

  validates_presence_of :discord_user_id, :username, :meta_data
end
