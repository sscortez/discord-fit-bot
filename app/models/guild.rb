# frozen_string_literal: true

class Guild < ApplicationRecord
  has_many :registered_users
  has_many :users, through: :registered_users

  validates_presence_of :discord_guild_id, :name, :meta_data
end
