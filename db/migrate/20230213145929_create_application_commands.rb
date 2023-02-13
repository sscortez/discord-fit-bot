# frozen_string_literal: true

class CreateApplicationCommands < ActiveRecord::Migration[7.0]
  def change
    create_table :application_commands do |t|
      t.references :discord_application,      null: false, foreign_key: true
      t.references :application_command_type, null: false, foreign_key: true

      t.string :discord_application_command_id, null: false, unique: true
      t.string :name,                           null: false, default: ''
      t.jsonb  :meta_data,                      null: false, default: {}

      t.timestamps
    end

    add_index :application_commands, %i[discord_application_id discord_application_command_id],
              unique: true, name: 'application_commands_index'
    add_index :application_commands, ['discord_application_command_id'], unique: true
  end
end
