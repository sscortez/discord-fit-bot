# frozen_string_literal: true

class CreateDiscordApplications < ActiveRecord::Migration[7.0]
  def change
    create_table :discord_applications do |t|
      t.string :discord_application_id, null: false, default: '', unique: true
      t.string :name,                   null: false, default: ''
      t.jsonb  :meta_data,              null: false, default: {}

      t.timestamps
    end

    add_index :discord_applications, ['discord_application_id'], unique: true
  end
end
