# frozen_string_literal: true

class CreateWebhookEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :webhook_events do |t|
      t.string  :request_id,   null: false, default: ''
      t.string  :request_type, null: false, default: ''
      t.string  :request_body, null: false, default: ''

      t.timestamps
    end
  end
end
