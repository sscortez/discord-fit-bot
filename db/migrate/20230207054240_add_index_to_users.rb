# frozen_string_literal: true

class AddIndexToUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :users, :discord_user_id, unique: true
  end
end
