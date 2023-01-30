# frozen_string_literal: true

FactoryBot.define do
  factory :webhook_event do
    sequence(:request_id) { |n| "some_request_id_#{n}" }

    request_type { 'some_service_type' }
    request_body { 'some_request_body' }
  end
end
