# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Guild, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:users) }
    it { is_expected.to have_many(:registered_users) }
  end

  it 'is valid with valid attributes' do
    expect(create(:guild)).to be_valid
  end

  describe 'validations' do
    subject { build(:guild) }

    it { is_expected.to validate_presence_of(:discord_guild_id) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:meta_data) }

    it { is_expected.to validate_uniqueness_of(:discord_guild_id) }
  end
end
