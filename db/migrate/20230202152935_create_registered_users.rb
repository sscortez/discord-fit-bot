# frozen_string_literal: true

class CreateRegisteredUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :registered_users do |t|
      t.references :user,  null: false, foreign_key: true
      t.references :guild, null: false, foreign_key: true

      t.timestamps
    end
  end
end
