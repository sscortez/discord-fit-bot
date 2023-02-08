# frozen_string_literal: true

module ApplicationCommands
  ##
  # Deletes user from guild's
  # fitbot community

  class Unregister
    UNREGISTERED = \
      'User %s is now unregistered!'
    NOT_REGISTERED = \
      'User is not registered in the first place.'

    def initialize(request_body)
      @request_body = request_body
    end

    def call
      registered_user = registered_user_exists?(user_id, guild_id)

      if registered_user
        RegisteredUsers::Unregister.new(registered_user).call
        user_unregistered_message(registered_user)
      else
        user_not_registered_message
      end
    end

    private

    def registered_user_exists?(user_id, guild_id)
      RegisteredUser.find_by(
        user: User.find_by(discord_user_id: user_id),
        guild: Guild.find_by(discord_guild_id: guild_id)
      )
    end

    def user_unregistered_message(registered_user)
      format(UNREGISTERED, registered_user.user.username)
    end

    def user_not_registered_message
      NOT_REGISTERED
    end

    def user_id
      @request_body['member']['user']['id']
    end

    def guild_id
      @request_body['guild_id']
    end
  end
end
