# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationCommands::Register do
  describe '#new' do
    context 'when an argument is provided' do
      let(:user)         { create(:user) }
      let(:guild)        { create(:guild) }
      let(:request_body) { test_request_body(user.discord_user_id, guild.discord_guild_id) }

      it 'creates a new instantiation of class' do
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
    context 'when user is not yet registered and user and guild are new' do
      let(:user)         { create(:user) }
      let(:guild)        { create(:guild) }
      let(:request_body) { test_request_body(user.discord_user_id, guild.discord_guild_id) }

      it 'creates a new user record' do
        expect do
          described_class.new(request_body).call
        end.to change(User, :count).by(1)
      end

      it 'creates a new guild' do
        expect do
          described_class.new(request_body).call
        end.to change(Guild, :count).by(1)
      end

      it 'creates a new registered_user' do
        expect do
          described_class.new(request_body).call
        end.to change(RegisteredUser, :count).by(1)
      end

      it 'returns a new registered_user object' do
        result = described_class.new(request_body).call

        expect(result.is_a?(RegisteredUser)).to be true
      end
    end

    context 'when user is not yet registered and user is new but guild exists' do
      before do
        @guild = create(:guild)
      end

      let(:user)         { create(:user) }
      let(:request_body) { test_request_body(user.discord_user_id, @guild.discord_guild_id) }

      it 'creates a new user record' do
        expect do
          described_class.new(request_body).call
        end.to change(User, :count).by(1)
      end

      it 'does not create a new guild record' do
        expect do
          described_class.new(request_body).call
        end.not_to change(Guild, :count)
      end

      it 'creates a new registered_user' do
        expect do
          described_class.new(request_body).call
        end.to change(RegisteredUser, :count).by(1)
      end

      it 'returns a new registered_user object' do
        result = described_class.new(request_body).call

        expect(result.is_a?(RegisteredUser)).to be true
      end
    end

    context 'when user is not yet registered and user exists but guild is new' do
      before do
        @user = create(:user)
      end

      let(:guild)        { create(:guild) }
      let(:request_body) { test_request_body(@user.discord_user_id, guild.discord_guild_id) }

      it 'does not create a new user record' do
        expect do
          described_class.new(request_body).call
        end.not_to change(User, :count)
      end

      it 'creates a new guild' do
        expect do
          described_class.new(request_body).call
        end.to change(Guild, :count).by(1)
      end

      it 'creates a new registered_user' do
        expect do
          described_class.new(request_body).call
        end.to change(RegisteredUser, :count).by(1)
      end

      it 'returns a new registered_user object' do
        result = described_class.new(request_body).call

        expect(result.is_a?(RegisteredUser)).to be true
      end
    end

    context 'when user is already registered' do
      before do
        @user =            create(:user)
        @guild =           create(:guild)
        @registered_user = create(:registered_user, user: @user, guild: @guild)
        @request_body =    test_request_body(@user.discord_user_id, @guild.discord_guild_id)
      end

      it 'does not create a new user record' do
        expect do
          described_class.new(@request_body).call
        end.not_to change(User, :count)
      end

      it 'does not create a new guild record' do
        expect do
          described_class.new(@request_body).call
        end.not_to change(Guild, :count)
      end

      it 'does not create a new registered_user record' do
        expect do
          described_class.new(@request_body).call
        end.not_to change(RegisteredUser, :count)
      end

      it 'returns an existing registered_user object' do
        result = described_class.new(@request_body).call

        expect(result).to eq(@registered_user)
      end
    end
  end

  private

  def test_request_body(user_id, guild_id)
    {
      'guild_id' => guild_id,
      'member' =>
        { 'user' => { 'id' => user_id } }
    }
  end
end
