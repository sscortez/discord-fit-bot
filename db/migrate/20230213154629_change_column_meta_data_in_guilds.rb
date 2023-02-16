# frozen_string_literal: true

class ChangeColumnMetaDataInGuilds < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:guilds, :meta_data, from: '', to: {})
  end
end
