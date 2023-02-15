# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'rake discord_applications:seed_discord_applications', type: :task do
  include_context 'when mocking discord client'

  it 'empties the application_command_types table before populating it' do
    mock_env
    client

    allow(DiscordApplication).to receive(:destroy_all)

    task.execute

    expect(DiscordApplication).to have_received(:destroy_all).once
  end

  it 'populates two records in the application_command_types table' do
    mock_env
    client

    task.execute

    expect(DiscordApplication.count).to eq(2)
  end

  it 'the first record matches expected values' do
    mock_env
    client

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
    mock_env
    client

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

  private

  def mock_env
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
