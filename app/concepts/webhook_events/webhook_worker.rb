# frozen_string_literal: true

module WebhookEvents
  class WebhookWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(webhook_event)
      create_webhook_event_record!(webhook_event)
    end

    private

    def webhook_event_exists?(webhook_event)
      WebhookEvents.find_by(
        request_id: webhook_event.id, 
        request_type: webhook_event.request_type
      )
    end

    def create_webhook_event_record!()
      webhook_event = webhook_events_exists?

      if webhook_event
        update_webhook_event!(webhook_event)
      else
        WebhookEvent.create!(
          request_id:   webhook_event.id,
          request_type: webhook_event.type,
          request_body: webhook_event.body
        )
      end
    end

    def update_webhook_event!(webhook_event)
      webhook_event.update!(request_body: webhook_event.body)
    end
  end
end
