# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebhookEvents::WebhookWorker do
  describe '#perform' do
    it 'saves webhook_event data to table and calls on service to act on data' do

      described_class.new.perform(1)
    end
  end
end
