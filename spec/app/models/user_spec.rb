# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attributes' do
    expect(create(:user)).to be_valid
  end

  it 'is not valid without a discord_id' do
    expect do
      user = build(:user, discord_id: nil)
      user.save!
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'is not valid without a discord_name' do
    expect do
      user = build(:user, discord_name: nil)
      user.save!
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
end
