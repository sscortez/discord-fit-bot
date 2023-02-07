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
    end

    private

    def user_registered?(request_body)
      record = user_registered?(request_body)
    end

    def register_user
    end

    def user_already_registered?(user)
      RegisteredUser.find_by()


      record = user_exists?(user['id'])

      if record
        true
      else
        create_user!
      end
    end

    def user_exists?(user_id)
      User.find_by(discord_id: user_id)
    end

    def server_exists?
    end

    def create_user!(user)
      new_user = user_details(user['id']).body
      User.create!(
        discord_id:       new_user['id'],
        discord_username: new_user['username'],
        discord_meta_ata: new_user
      )
    end

    def create_server!
    end

    def user_details(user_id)
      @client.get_user(user_id)
    end

    def user_data
      @request_body['member']['user']
    end
  end
end
