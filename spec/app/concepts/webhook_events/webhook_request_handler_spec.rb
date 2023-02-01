# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebhookEvents::WebhookRequestHandler do
  describe '#call' do
    context 'when request data is valid' do
      it 'calls perform_async' do
        request = 'some_request'

        allow(WebhookEvents::WebhookWorker)
          .to receive(:perform_async)
          .with(request)
          .once

        described_class.new(request).call

        expect(WebhookEvents::WebhookWorker)
          .to have_received(:perform_async)
          .with(request)
          .once
      end
    end
  end
end
