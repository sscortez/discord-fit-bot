# frozen_string_literal: true

class Guild < ApplicationRecord
  has_many :registered_users, dependent: nil
  has_many :users, through: :registered_users
  has_many :guild_monthly_challenges, dependent: nil

  validates :name, :meta_data, presence: true
  validates :discord_guild_id, presence: true, uniqueness: true
end
