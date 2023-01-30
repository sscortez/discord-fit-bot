# frozen_string_literal: true

module WebhookEvents
  class WebhookWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(webhook_event)
      p "This is a webhook event: #{webhook_event}"
      binding.pry
      # TO DO: Complete this method
    end

    private

    def webhook_events_exists?(webhook_event)
      WebhookEvents.find_by()
    end

    def create_webhook_events_record!()
      webhooK_event = webhook_events_exists?
      WebhookEvent.create!
    end
  end
end
