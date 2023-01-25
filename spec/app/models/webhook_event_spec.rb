# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebhookEvent, type: :model do
  it 'is valid with valid attributes' do
    expect(create(:webhook_event)).to be_valid
  end

  it 'is not valid without a service_name' do
    expect do
      webhook_event = build(:webhook_event, service_name: nil)
      webhook_event.save!
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'is not valid without a service_type' do
    expect do
      webhook_event = build(:webhook_event, service_type: nil)
      webhook_event.save!
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'is not valid without a request_signature' do
    expect do
      webhook_event = build(:webhook_event, request_signature: nil)
      webhook_event.save!
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'is not valid without a request_body' do
    expect do
      webhook_event = build(:webhook_event, request_body: nil)
      webhook_event.save!
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
end
