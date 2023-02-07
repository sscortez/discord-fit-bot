# frozen_string_literal: true

class AddIndexToGuilds < ActiveRecord::Migration[7.0]
  def change
    add_index :guilds, :discord_guild_id, unique: true
  end
end
