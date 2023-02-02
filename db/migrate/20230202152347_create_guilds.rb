class CreateGuilds < ActiveRecord::Migration[7.0]
  def change
    create_table :guilds do |t|
      t.string :discord_guild_id, null: false, default: ''
      t.string :name,             null: false, default: ''
      t.jsonb  :meta_data,        null: false, default: ''

      t.timestamps
    end
  end
end
