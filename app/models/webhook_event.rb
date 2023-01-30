# frozen_string_literal: true

class WebhookEvent < ApplicationRecord
  has_many :interactions, dependent: nil

  validates :request_id,   presence: true
  validates :request_type, presence: true
  validates :request_body, presence: true
end
