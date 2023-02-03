# frozen_string_literal: true

class Guild < ApplicationRecord
  has_many :registered_users, dependent: nil
  has_many :users, through: :registered_users

  validates :discord_guild_id, :name, :meta_data, presence: true
end
