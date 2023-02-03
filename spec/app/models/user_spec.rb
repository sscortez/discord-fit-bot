# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:guilds) }
    it { is_expected.to have_many(:registered_users) }
  end

  it 'is valid with valid attributes' do
    expect(create(:user)).to be_valid
  end

  describe 'validations' do
    subject { build(:user) }

    it { is_expected.to validate_presence_of(:discord_user_id) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:meta_data) }
  end
end
