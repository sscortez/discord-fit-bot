# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebhookEvent, type: :model do
  it 'is valid with valid attributes' do
    expect(create(:webhook_event)).to be_valid
  end

  it 'is not valid without a request_id' do
    expect do
      webhook_event = build(:webhook_event, request_id: nil)
      webhook_event.save!
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'is not valid without a request_type' do
    expect do
      webhook_event = build(:webhook_event, request_type: nil)
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
