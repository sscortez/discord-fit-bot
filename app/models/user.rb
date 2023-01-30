# frozen_string_literal: true

class User < ApplicationRecord
  validates :discord_id,        presence: true
  validates :discord_name,      presence: true
  validates :discord_meta_data, presence: true
end
