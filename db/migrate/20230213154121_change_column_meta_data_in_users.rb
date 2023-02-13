# frozen_string_literal: true

class ChangeColumnMetaDataInUsers < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:users, :meta_data, from: '', to: {})
  end
end
