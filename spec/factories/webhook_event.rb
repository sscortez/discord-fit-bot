# frozen_string_literal: true

FactoryBot.define do
  factory :webhook_event do
    service_name      { 'some_service_name' }
    service_type      { 'some_service_type' }
    request_signature { 'some_request_signature' }
    request_body      { 'some_request_body' }
  end
end
