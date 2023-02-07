# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationCommands::Register do
  describe '#new' do
    context 'when an argument is provided' do
      it 'creates a new instantiation of class' do
        expect do
          described_class.new(test_request_body)
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

  private

  def test_request_body
    {"app_permissions"=>"4398046511103",
      "application_id"=>"1068352272997826637",
      "channel_id"=>"1067095363938435153",
      "data"=>{"id"=>"1068357917323051048", "name"=>"test", "type"=>1},
      "entitlement_sku_ids"=>[],
      "guild_id"=>"1067095234758054008",
      "guild_locale"=>"en-US",
      "id"=>"1068358256302506175",
      "locale"=>"en-US",
      "member"=>
        {"avatar"=>nil,
        "communication_disabled_until"=>nil,
        "deaf"=>false,
        "flags"=>0,
        "is_pending"=>false,
        "joined_at"=>"2023-01-23T14:55:29.664000+00:00",
        "mute"=>false,
        "nick"=>nil,
        "pending"=>false,
        "permissions"=>"4398046511103",
        "premium_since"=>nil,
        "roles"=>[],
        "user"=>{"avatar"=>"d923d2a23a4778e656c9187ef9b0661a", "avatar_decoration"=>nil, "discriminator"=>"0767", "display_name"=>nil, "id"=>"564607183292203009", "public_flags"=>0, "username"=>"instantcoffee16"}},
      "token"=>"aW50ZXJhY3Rpb246MTA2ODM1ODI1NjMwMjUwNjE3NTp0ajdjeHpNdGtLQnFCSkJGUzUzbTI1N3p0bTNCcnVsUTdZZGJVUXdNQXRMdDdFSDlodUN2c3FiWW1La3ZxbHN0OEdMQjlrQnNhd09INEVGQnYwenF2a21nM0RrdDI4NkNIdFE3YThxckVPZzFyalZNdWV5M2tsVG0xMWttYm9leA",
      "type"=>2,
      "version"=>1}
  end
end
