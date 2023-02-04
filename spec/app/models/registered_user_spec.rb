# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RegisteredUser, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:guild) }
    it { is_expected.to belong_to(:user) }
  end

  it 'is valid with valid attributes' do
    expect(create(:registered_user)).to be_valid
  end

  describe 'validations' do
    subject { build(:registered_user) }

    it { is_expected.to validate_presence_of(:uuid) }
    it { is_expected.to validate_uniqueness_of(:user).scoped_to(:guild_id) }
  end
end
