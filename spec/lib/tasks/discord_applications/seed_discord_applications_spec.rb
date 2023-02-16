# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'rake discord_applications:seed_discord_applications', type: :task do
  include_context 'when using discord client'

  it 'empties the application_command_types table before populating it' do
    stub_client_method(client)

    allow(DiscordApplication).to receive(:destroy_all)

    task.execute

    expect(DiscordApplication).to have_received(:destroy_all).once
  end

  it 'populates two records in the application_command_types table' do
    stub_client_method(client)

    task.execute

    expect(DiscordApplication.count).to eq(2)
  end

  it 'the first record matches expected values' do
    stub_client_method(client)

    task.execute

    first_record = DiscordApplication.first

    expect(first_record.name).to eq('some_app_name_1')
    expect(first_record.discord_application_id).to eq('some_app_id_1')
    expect(first_record.meta_data).to eq(
      {
        'id'   => 'some_app_id_1',
        'name' => 'some_app_name_1'
      }
    )
  end

  it 'the second record matches expected values' do
    stub_client_method(client)

    task.execute

    second_record = DiscordApplication.second

    expect(second_record.name).to eq('some_app_name_2')
    expect(second_record.discord_application_id).to eq('some_app_id_2')
    expect(second_record.meta_data).to eq(
      {
        'id'   => 'some_app_id_2',
        'name' => 'some_app_name_2'
      }
    )
  end

  it 'calls client method #get_application twice' do
    stub_client_method(client)

    task.execute

    expect(client).to have_received(:get_application).twice
  end

  private

  ##
  # Stubs #get_application

  def stub_client_method(client)
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
  end
end
