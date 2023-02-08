# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationCommands::Unregister do
  describe '#new' do
    context 'when request_body provided' do
      it 'creates a new instantiation of class' do
        request_body = 'some_request_body'

        expect do
          described_class.new(request_body)
        end.not_to raise_error
      end
    end

    context 'when no argument is passed' do
      it 'raises ArgumentError' do
        expect do
          described_class.new
        end.to raise_error(ArgumentError)
      end
    end
  end

  describe '#call' do
    context 'when user is currently registered' do
      let(:user) { create(:user) }
      let(:guild) { create(:guild) }
      let(:registered_user) { create(:registered_user, user: ) }

      it 'returns a user-unregistered message' do
        request_body = {
          'guild_id' => registered_user.guild.discord_guild_id,
          'member' => {
            'user' => { 'id' => registered_user.user.discord_user_id }
          }
        }

        result = described_class.new(request_body).call

        expect(result).to eq(
          format(
            ApplicationCommands::Unregister::UNREGISTERED,
            registered_user.user.username
          )
        )
      end
    end

    context 'when user is not registered' do
      it 'returns a user-not-registered message' do
        request_body = {
          'guild_id' => 'some_non-existent_discord_guild_id',
          'member' => {
            'user' => { 'id' => 'some_non-existent_discord_user_id' }
          }
        }

        result = described_class.new(request_body).call

        expect(result).to eq(ApplicationCommands::Unregister::NOT_REGISTERED)
      end
    end
  end
end
