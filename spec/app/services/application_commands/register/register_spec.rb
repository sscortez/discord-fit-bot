# frozen_string_literal: true

require 'rails_helper'
require 'discord_client'

RSpec.describe ApplicationCommands::Register::Register do
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
    let(:user_obj)        { build(:user) }
    let(:guild_obj)       { build(:guild) }
    let(:registered_user) { build(:registered_user, user: user_obj, guild: guild_obj) }

    context 'when user already exists' do
      it 'returns a user-already-exists message' do
        user_obj.save
        guild_obj.save
        registered_user.save

        request_body = dummy_request_body(user_obj.discord_user_id, guild_obj.discord_guild_id)

        response = described_class.new(request_body).call

        expect(response).to eq(
          format(
            ApplicationCommands::Register::Register::ALREADY_REGISTERED,
            user_obj.username,
            guild_obj.name
          )
        )
      end
    end

    context 'when user is not yet registered' do
      let(:request_body) { dummy_request_body(user_obj.discord_user_id, guild_obj.discord_guild_id) }

      let(:client) do
        client = instance_double(DiscordClient)

        allow(DiscordClient).to receive(:new).and_return(client)
        allow(client)
          .to receive(:get_user)
          .and_return(
            double(
              body: { 'id' => user_obj.discord_user_id, 'username' => 'some_username' }
            )
          )
        allow(client)
          .to receive(:get_guild)
          .and_return(
            double(
              body: { 'id' => guild_obj.discord_guild_id, 'name' => 'some_name' }
            )
          )

        client
      end

      it 'returns a user-is-now registered message' do
        client

        response = described_class.new(request_body).call

        expect(response).to eq(
          format(
            ApplicationCommands::Register::Register::NOW_REGISTERED,
            user_obj.username,
            guild_obj.name
          )
        )
      end
    end

    context 'when there is an error trying to create a new registered user' do
      let(:register_user_call) do
        ru_call = instance_double(ApplicationCommands::Register::RegisterUser)

        allow(ApplicationCommands::Register::RegisterUser).to receive(:new).and_return(ru_call)
        allow(ru_call).to receive(:call).and_raise(ActiveRecord::RecordInvalid)

        ru_call
      end

      it 'returns an error message' do
        request_body = dummy_request_body(user_obj.discord_user_id, guild_obj.discord_guild_id)
        register_user_call

        response = described_class.new(request_body).call

        expect(response).to eq(ApplicationCommands::Register::Register::ERRORED)
      end
    end
  end

  private

  def dummy_request_body(user_id, guild_id)
    {
      'guild_id' => guild_id,
      'member' => {
        'user' => { 'id' => user_id }
      }
    }
  end
end
