# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    expect(
      User.create!(discord_id: 'some_discord_id', discord_name: 'some_discord_name')
    ).to be_valid
  end

  it 'is not valid without a discord_id' do
    expect do
      User.create!(discord_id: nil, discord_name: 'some_discord_name')
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'is not valid without a discord_name' do
    expect do
      User.create!(discord_id: 'some_discord_id', discord_name: nil)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
end
