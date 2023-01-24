# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :discord_name
      t.string :discord_id

      t.timestamps
    end
  end
end
