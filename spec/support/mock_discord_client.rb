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

RSpec.shared_context 'when mocking discord client', shared_context: :metadata do
  # Mocks Discord Client
  let(:client) do
    client = instance_double(DiscordClient)

    allow(DiscordClient)
      .to receive(:new)
      .with(kind_of(String))
      .and_return(client)
    allow(client)
      .to receive(:get_application)
      .and_return(
        double(
          body: {
            'id'   => 'some_app_id_1',
            'name' => 'some_app_name_1'
          }
        ),
        double(
          body: {
            'id'   => 'some_app_id_2',
            'name' => 'some_app_name_2'
          }
        )
      )

    client
  end
end

RSpec.configure do |rspec|
  rspec.include_context 'when mocking discord client', include_shared: true
end
