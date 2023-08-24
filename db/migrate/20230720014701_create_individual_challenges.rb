# frozen_string_literal: true

class CreateIndividualChallenges < ActiveRecord::Migration[7.0]
  def change
    create_table :individual_challenges do |t|
      t.references :registered_user, null: false, foreign_key: true

      t.date    :challenge_date,     null: false
      t.string  :month_year,         null: false
      t.integer :monthly_goal_count, null: false

      t.timestamps
    end

    add_index :individual_challenges, %i[registered_user_id id], unique: true
  end
end
