# frozen_string_literal: true

class CreateInteractions < ActiveRecord::Migration[7.0]
  def change
    create_table :interactions do |t|
      t.references :webhook_event

      t.string :interaction_id, null: false, default: ''
      t.string :service_name,   null: false, default: ''
      t.string :type,           null: false, default: ''
      t.string :timestamp,      null: false, default: ''
      t.jsonb  :meta_data,      null: false, default: {}

      t.timestamps
    end
  end
end
