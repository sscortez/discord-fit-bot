# frozen_string_literal: true

module ApplicationCommands
  module Register
    ##
    # Checks registration and responds
    # with registration process result
    class Register
      ALREADY_REGISTERED = \
        'User %s is already registered with FitBot app in server %s!'
      NOW_REGISTERED = \
        'User %s is now registered with FitBot app in server %s.'
      ERRORED = \
        'Error! Unable to register user with FitBot. ' \
        'Please reach out to an administrator for assistance.'

      def initialize(request_body)
        @request_body = request_body
      end

      ##
      # Checks if user is already registered.
      # If no match are found, then create a new
      # user and/or server record.
      # Returns a string showing the result of the
      # registration process for display to the user

      def call
        registered_user = user_already_registered?(user_id, guild_id)

        if registered_user
          user_already_registered_message(registered_user)
        else
          registered_user = RegisterUser.new(user_id, guild_id).call
          new_user_registered_message(registered_user)
        end
      rescue ActiveRecord::RecordInvalid
        ERRORED
      end

      private

      def user_already_registered?(user_id, guild_id)
        RegisteredUser.find_by(
          user: User.find_by(discord_user_id: user_id),
          guild: Guild.find_by(discord_guild_id: guild_id)
        )
      end

      def user_already_registered_message(registered_user)
        format(
          ALREADY_REGISTERED,
          registered_user.user.username,
          registered_user.guild.name
        )
      end

      def new_user_registered_message(registered_user)
        format(
          NOW_REGISTERED,
          registered_user.user.username,
          registered_user.guild.name
        )
      end

      def user_id
        @request_body['member']['user']['id']
      end

      def guild_id
        @request_body['guild_id']
      end
    end
  end
end
