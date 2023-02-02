# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :username,        null: false, default: ''
      t.string :discord_user_id, null: false, default: ''
      t.jsonb  :meta_data,       null: false, default: ''

      t.timestamps
    end
  end
end
