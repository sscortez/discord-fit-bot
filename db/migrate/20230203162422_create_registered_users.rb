# frozen_string_literal: true

class CreateRegisteredUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :registered_users do |t|
      t.references :user,  null: false, foreign_key: true
      t.references :guild, null: false, foreign_key: true

      t.uuid :uuid, null: false

      t.timestamps
    end

    add_index :registered_users, %i[user_id guild_id], unique: true
  end
end
