# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'rake discord_applications:seed_application_command_types', type: :task do
  it 'empties the application_command_types table before populating it' do
    allow(ApplicationCommandType).to receive(:destroy_all)

    task.execute

    expect(ApplicationCommandType).to have_received(:destroy_all).once
  end

  it 'populates three records in the application_command_types table' do
    task.execute

    expect(ApplicationCommandType.count).to eq(3)
  end

  it 'populates the first record as type CHAT_INPUT' do
    task.execute

    first_record = ApplicationCommandType.first

    expect(first_record.name).to eq('CHAT_INPUT')
    expect(first_record.description).to eq('Slash commands; a text-based command that shows up when a user types /')
  end

  it 'populates the second record as type USER' do
    task.execute

    second_record = ApplicationCommandType.second

    expect(second_record.name).to eq('USER')
    expect(second_record.description).to eq('A UI-based command that shows up when you right click or tap on a user')
  end

  it 'populates the third record as type MESSAGE' do
    task.execute

    third_record = ApplicationCommandType.third

    expect(third_record.name).to eq('MESSAGE')
    expect(third_record.description).to eq('A UI-based command that shows up when you right click or tap on a message')
  end
end
