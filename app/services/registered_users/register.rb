# frozen_string_literal: true

require 'discord_client'
require 'securerandom'

module RegisteredUsers
  ##
  # Registers user in the app

  class Register
    def initialize(user_id, guild_id, application_id)
      @user_id  = user_id
      @guild_id = guild_id
      @client   = DiscordClient.new(application_id)
    end

    def call
      register_new_user!(@user_id, @guild_id)
    end

    private

    def register_new_user!(user_id, guild_id)
      user = user_exists?(user_id) || create_user!(user_id)

      guild = guild_exists?(guild_id) || create_guild!(guild_id)

      create_registered_user!(user, guild)
    end

    def user_exists?(user_id)
      User.find_by(discord_user_id: user_id)
    end

    def guild_exists?(guild_id)
      Guild.find_by(discord_guild_id: guild_id)
    end

    def create_user!(user_id)
      new_user = user_details(user_id).body

      User.create!(
        discord_user_id: new_user['id'],
        username:        new_user['username'],
        meta_data:       new_user
      )
    end

    def create_guild!(guild_id)
      new_guild = guild_details(guild_id).body

      Guild.create!(
        discord_guild_id: new_guild['id'],
        name:             new_guild['name'],
        meta_data:        new_guild
      )
    end

    def create_registered_user!(user_obj, guild_obj)
      RegisteredUser.create!(user: user_obj, guild: guild_obj, uuid: SecureRandom.uuid)
    end

    def user_details(user_id)
      @client.get_user(user_id)
    end

    def guild_details(guild_id)
      @client.get_guild(guild_id)
    end
  end
end
