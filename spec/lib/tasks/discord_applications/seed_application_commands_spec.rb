# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'rake discord_applications:seed_application_commands', type: :task do
  include_context 'when using discord client'

  it 'empties the application_command_types table before populating it' do
    create_prerequisite_records
    stub_client_method(client)

    allow(ApplicationCommand).to receive(:destroy_all)

    task.execute

    expect(ApplicationCommand).to have_received(:destroy_all).once
  end

  it 'populates three records in the application_command_types table' do
    create_prerequisite_records
    stub_client_method(client)

    task.execute

    expect(ApplicationCommand.count).to eq(3)
  end

  it 'the first record matches expected values' do
    create_prerequisite_records
    stub_client_method(client)

    task.execute

    first_record = ApplicationCommand.first

    expect(first_record.name).to                                       eq('some_application_command_name_1')
    expect(first_record.discord_application.discord_application_id).to eq('some_app_id_1')
    expect(first_record.application_command_type.id).to                eq(1)
    expect(first_record.discord_application_command_id).to             eq('some_command_id_1')
    expect(first_record.meta_data).to eq(
      {
        'application_id' => 'some_app_id_1',
        'type' =>           1,
        'id' =>             'some_command_id_1',
        'name' =>           'some_application_command_name_1'
      }
    )
  end

  it 'the last record matches expected values' do
    create_prerequisite_records
    stub_client_method(client)

    task.execute

    last_record = ApplicationCommand.last

    expect(last_record.name).to                                       eq('some_application_command_name_3')
    expect(last_record.discord_application.discord_application_id).to eq('some_app_id_2')
    expect(last_record.application_command_type.id).to                eq(1)
    expect(last_record.discord_application_command_id).to             eq('some_command_id_3')
    expect(last_record.meta_data).to eq(
      {
        'application_id' => 'some_app_id_2',
        'type' =>           1,
        'id' =>             'some_command_id_3',
        'name' =>           'some_application_command_name_3'
      }
    )
  end

  it 'calls client method #get_application_commands twice' do
    create_prerequisite_records
    stub_client_method(client)

    task.execute

    expect(client).to have_received(:get_application_commands).twice
  end

  private

  ##
  # Stubs #get_application_commands

  def stub_client_method(client)
    allow(client)
      .to receive(:get_application_commands)
      .and_return(
        double(
          body: [
            {
              'application_id' => 'some_app_id_1',
              'type' =>           1,
              'id' =>             'some_command_id_1',
              'name' =>           'some_application_command_name_1'
            },
            {
              'application_id' => 'some_app_id_1',
              'type' =>           1,
              'id' =>             'some_command_id_2',
              'name' =>           'some_application_command_name_2'
            }
          ]
        ),
        double(
          body: [
            {
              'application_id' => 'some_app_id_2',
              'type' =>           1,
              'id' =>             'some_command_id_3',
              'name' =>           'some_application_command_name_3'
            }
          ]
        )
      )

    client
  end

  def create_prerequisite_records
    create(:discord_application, discord_application_id: 'some_app_id_1')
    create(:discord_application, discord_application_id: 'some_app_id_2')

    create(:application_command_type, id: 1)
  end
end
