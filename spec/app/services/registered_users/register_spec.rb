# frozen_string_literal: true

require 'rails_helper'
require 'discord_client'

RSpec.describe RegisteredUsers::Register do
  describe '#new' do
    context 'when user_id and guild_id are provided' do
      it 'creates a new instantiation of class' do
        user_id = 'some_user_id'
        guild_id = 'some_guild_id'

        expect do
          described_class.new(user_id, guild_id)
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
    let(:client) do
      client = instance_double(DiscordClient)

      allow(DiscordClient).to receive(:new).and_return(client)
      allow(client)
        .to receive(:get_user)
        .and_return(
          double(
            body: { 'id' => 'some_user_id', 'username' => 'some_username' }
          )
        )
      allow(client)
        .to receive(:get_guild)
        .and_return(
          double(
            body: { 'id' => 'some_guild_id', 'name' => 'some_name' }
          )
        )

      client
    end

    context 'when user is not yet registered and user and guild are new' do
      let(:user)  { build(:user) }
      let(:guild) { build(:guild) }

      it 'creates a new user record' do
        client

        expect do
          described_class.new(user.discord_user_id, guild.discord_guild_id).call
        end.to change(User, :count).by(1)
      end

      it 'creates a new guild' do
        client

        expect do
          described_class.new(user.discord_user_id, guild.discord_guild_id).call
        end.to change(Guild, :count).by(1)
      end

      it 'creates a new registered_user' do
        client

        expect do
          described_class.new(user.discord_user_id, guild.discord_guild_id).call
        end.to change(RegisteredUser, :count).by(1)
      end

      it 'returns a new registered_user object' do
        client

        result = described_class.new(user.discord_user_id, guild.discord_guild_id).call

        expect(result.is_a?(RegisteredUser)).to be true
      end

      it 'initializes a discord client' do
        client

        described_class.new(user.discord_user_id, guild.discord_guild_id).call

        expect(DiscordClient).to have_received(:new).once
      end

      it 'calls discord_client.get_user once' do
        client

        described_class.new(user.discord_user_id, guild.discord_guild_id).call

        expect(client).to have_received(:get_user).once
      end

      it 'calls discord_client.get_guild once' do
        client

        described_class.new(user.discord_user_id, guild.discord_guild_id).call

        expect(client).to have_received(:get_guild).once
      end
    end

    context 'when user is not yet registered and user is new but guild exists' do
      let(:user)  { build(:user) }
      let(:guild) { build(:guild) }

      it 'creates a new user record' do
        guild.save
        client

        expect do
          described_class.new(user.discord_user_id, guild.discord_guild_id).call
        end.to change(User, :count).by(1)
      end

      it 'does not create a new guild record' do
        guild.save
        client

        expect do
          described_class.new(user.discord_user_id, guild.discord_guild_id).call
        end.not_to change(Guild, :count)
      end

      it 'creates a new registered_user' do
        guild.save
        client

        expect do
          described_class.new(user.discord_user_id, guild.discord_guild_id).call
        end.to change(RegisteredUser, :count).by(1)
      end

      it 'returns a new registered_user object' do
        guild.save
        client

        result = described_class.new(user.discord_user_id, guild.discord_guild_id).call

        expect(result.is_a?(RegisteredUser)).to be true
      end

      it 'initializes a discord client' do
        client

        described_class.new(user.discord_user_id, guild.discord_guild_id).call

        expect(DiscordClient).to have_received(:new).once
      end

      it 'calls discord_client.get_user once' do
        client

        described_class.new(user.discord_user_id, guild.discord_guild_id).call

        expect(client).to have_received(:get_user).once
      end
    end

    context 'when user is not yet registered and user exists but guild is new' do
      let(:user)  { build(:user) }
      let(:guild) { build(:guild) }

      it 'does not create a new user record' do
        user.save
        client

        expect do
          described_class.new(user.discord_user_id, guild.discord_guild_id).call
        end.not_to change(User, :count)
      end

      it 'creates a new guild' do
        user.save
        client

        expect do
          described_class.new(user.discord_user_id, guild.discord_guild_id).call
        end.to change(Guild, :count).by(1)
      end

      it 'creates a new registered_user' do
        user.save
        client

        expect do
          described_class.new(user.discord_user_id, guild.discord_guild_id).call
        end.to change(RegisteredUser, :count).by(1)
      end

      it 'returns a new registered_user object' do
        user.save
        client

        result = described_class.new(user.discord_user_id, guild.discord_guild_id).call

        expect(result.is_a?(RegisteredUser)).to be true
      end

      it 'initializes a discord client' do
        client

        described_class.new(user.discord_user_id, guild.discord_guild_id).call

        expect(DiscordClient).to have_received(:new).once
      end

      it 'calls discord_client.get_guild once' do
        client

        described_class.new(user.discord_user_id, guild.discord_guild_id).call

        expect(client).to have_received(:get_guild).once
      end
    end

    context 'when user is already registered' do
      let(:user_obj)            { build(:user) }
      let(:guild_obj)           { build(:guild) }
      let(:registered_user) { build(:registered_user, user: user_obj, guild: guild_obj) }

      it 'raises ActiveRecord::RecordInvalid error' do
        user_obj.save
        guild_obj.save
        registered_user.save

        expect do
          described_class.new(user_obj.discord_user_id, guild_obj.discord_guild_id).call
        end.to raise_error(ActiveRecord::RecordInvalid)
      end

      it 'initializes a discord client' do
        client

        described_class.new(user_obj.discord_user_id, guild_obj.discord_guild_id).call

        expect(DiscordClient).to have_received(:new).once
      end
    end
  end
end
