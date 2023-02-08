# frozen_string_literal: true

require 'rails_helper'
require 'discord_client'

RSpec.describe DiscordClient do
  describe '#new' do
    context 'when arguments are valid' do
      it 'successfully creates a new instance of DiscordClient object' do
        application_id = 'some_application_id'

        expect do
          described_class.new(application_id)
        end.not_to raise_error
      end
    end
  end
end
