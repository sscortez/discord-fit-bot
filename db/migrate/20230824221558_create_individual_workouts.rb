# frozen_string_literal: true

class CreateIndividualWorkouts < ActiveRecord::Migration[7.0]
  def change
    create_table :individual_workouts do |t|
      t.references :registered_user, null: false, foreign_key: true

      t.date    :workout_date,  null: false
      t.string  :month_year,    null: false
      t.integer :duration_mins, null: false

      t.timestamps
    end
  end
end
