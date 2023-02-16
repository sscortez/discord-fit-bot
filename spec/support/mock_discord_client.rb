# frozen_string_literal: true

require 'discord_client'

RSpec.configure do |rspec|
  # This config option will be enabled by default on RSpec 4,
  # but for reasons of backwards compatibility, you have to
  # set it on RSpec 3.
  #
  # It causes the host group and examples to inherit metadata
  # from the shared context.
  rspec.shared_context_metadata_behavior = :apply_to_host_groups
end

# Mocks Discord Client and stubs its attributes and methods
RSpec.shared_context 'when using discord client', shared_context: :metadata do
  let(:client) do
    client = instance_double(DiscordClient)

    # stubs #new
    allow(DiscordClient)
      .to receive(:new)
      .with(kind_of(String))
      .and_return(client)

    client
  end

  before do
    allow(ENV)
      .to receive(:fetch)
      .with('FITBOT_APPLICATION_ID')
      .and_return('some_fitbot_application_id')
    allow(ENV)
      .to receive(:fetch)
      .with('TESTAPP_APPLICATION_ID')
      .and_return('some_testapp_application_id')
  end
end

RSpec.configure do |rspec|
  rspec.include_context 'when using discord client', include_shared: true
end
