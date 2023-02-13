# frozen_string_literal: true

class CreateApplicationCommandTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :application_command_types do |t|
      t.string :name,        null: false, default: ''
      t.string :description, null: false, default: ''

      t.timestamps
    end
  end
end
