# frozen_string_literal: true

require 'discord_client'

module ApplicationCommands
  ##
  # Adds a user to the "app community"
  class Register
    def initialize(request_body)
      @request_body = request_body
      @client       = DiscordClient.new
    end

    ##
    # Checks user and server records
    # If no match are found, then create a new
    # user and/or server record

    def call
      register_user(user_id, guild_id)
    end

    private

    def register_user(user_id, guild_id)
      record = user_already_registered?(user_id, guild_id)

      record || register_new_user!(user_id, guild_id)
    end

    def user_already_registered?(user_id, guild_id)
      RegisteredUser.find_by(
        user: User.find_by(discord_user_id: user_id),
        guild: Guild.find_by(discord_guild_id: guild_id)
      )
    end

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
        meta_ata:        new_user
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
      RegisteredUser.create!(user: user_obj, guild: guild_obj)
    end

    def user_id
      @request_body['member']['user']['id']
    end

    def guild_id
      @request_body['guild_id']
    end

    def user_details(user_id)
      @client.get_user(user_id)
    end

    def guild_details(guild_id)
      @client.get_guild(guild_id)
    end
  end
end
