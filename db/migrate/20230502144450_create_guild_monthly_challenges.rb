class CreateGuildMonthlyChallenges < ActiveRecord::Migration[7.0]
  def change
    create_table :guild_monthly_challenges do |t|
      t.references :guild, null: false, foreign_key: true

      t.date    :month_year,       null: false
      t.integer :target_exercises, null: false, default: 0
      t.boolean :active,           null: false, default: true

      t.timestamps
    end
  end
end
