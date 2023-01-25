# frozen_string_literal: true

FactoryBot.define do
  factory :interaction do
    webhook_event

    sequence(:interaction_id) { |n| "some_interaction_id_#{n}" }

    service_name   { 'some_service_name' }
    type           { 'some_service_type' }
    timestamp      { 'some_request_signature' }
    meta_data      { 'some_request_body' }
  end
end
