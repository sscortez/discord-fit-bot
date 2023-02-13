# frozen_string_literal: true

FactoryBot.define do
  factory :application_command_type do
    sequence(:id) { |n| "some_application_command_type_id_#{n}" }

    name        { 'some_application_command_type_name' }
    description { 'some_application_command_type_description' }
  end
end
