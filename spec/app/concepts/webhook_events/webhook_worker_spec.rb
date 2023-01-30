# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebhookEvents::WebhookWorker do
  describe '#perform' do
    context 'when webhook_event data is new' do
      it 'saves webhook_event data to table' do
        request = WebhookEvents::WebhookValidator::ValidatedRequest.new('some_id', 'some_type', 'some_body')
        
        expect do
          described_class.new.perform(request)
        end.to change(WebhookEvent, :count).by(1)

        record = WebhookEvent.all.last
        expect(record.request_id).to   eq(request.id)
        expect(record.request_type).to eq(request.type)
        expect(record.request_body).to eq(request.body)
      end
    end

    context 'when webhook_event data already exists' do
      it 'updates existing data in table' do
        create(
          :webhook_event, 
          request_id: 'some_id', 
          request_type: 'some_type', 
          request_body: 'some_old_body'
        )

        request = WebhookEvents::WebhookValidator::ValidatedRequest.new('some_id', 'some_type', 'some_body')
        
        expect do
          described_class.new.perform(request)
        end.not_to change(WebhookEvent, :count)

        record = WebhookEvent.all.last
        expect(record.request_id).to   eq(request.id)
        expect(record.request_type).to eq(request.type)
        expect(record.request_body).to eq(request.body)
      end
    end
  end
end
