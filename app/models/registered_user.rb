# frozen_string_literal: true

class RegisteredUser < ApplicationRecord
  belongs_to :user
  belongs_to :guild
end
