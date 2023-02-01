# frozen_string_literal: true

require 'rails_helper'
require 'discord_client'

RSpec.describe DiscordClient do
  describe '#new' do
    context 'when arguments are valid' do
      it 'successfully creates a new instance of DiscordClient object' do
        expect do
          described_class.new
        end.not_to raise_error
      end
    end
  end
end
