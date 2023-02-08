# frozen_string_literal: true

module RegisteredUsers
  ##
  # Deletes registered user record

  class Unregister
    def initialize(registered_user)
      @registered_user = registered_user
    end

    def call
      delete_registered_user!(@registered_user)
    end

    def delete_registered_user!(registered_user)
      registered_user.destroy!
    end
  end
end
