# frozen_string_literal: true

class WebhookEvent < ApplicationRecord
  has_many :interactions, dependent: nil

  validates :service_name,      presence: true
  validates :service_type,      presence: true
  validates :request_signature, presence: true
  validates :request_body,      presence: true
end
