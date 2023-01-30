# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :discord_name,      null: false
      t.string :discord_id,        null: false
      t.string :discord_meta_data, null: false

      t.timestamps
    end
  end
end
