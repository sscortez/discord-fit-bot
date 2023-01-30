# frozen_string_literal: true

module WebhookEvents
  ##
  # Updates or creates webhook_event records
  class WebhookWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(webhook_event)
      create_webhook_event_record!(webhook_event)
    end

    private

    def webhook_event_exists?(webhook_event)
      WebhookEvent.find_by(
        request_id: webhook_event.id,
        request_type: webhook_event.type
      )
    end

    def create_webhook_event_record!(webhook_event)
      record = webhook_event_exists?(webhook_event)

      if record
        update_webhook_event!(record, webhook_event)
      else
        WebhookEvent.create!(
          request_id:   webhook_event.id,
          request_type: webhook_event.type,
          request_body: webhook_event.body
        )
      end
    end

    def update_webhook_event!(record, webhook_event)
      record.update!(request_body: webhook_event.body)
    end
  end
end
