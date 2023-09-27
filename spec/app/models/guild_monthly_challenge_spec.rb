# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GuildMonthlyChallenge, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:guild) }
  end

  it 'is valid with valid attributes' do
    expect(create(:guild_monthly_challenge)).to be_valid
  end

  describe 'validations' do
    subject { build(:guild_monthly_challenge) }

    it { is_expected.to validate_presence_of(:month_year) }
    it { is_expected.to validate_presence_of(:target_exercises) }
    it { is_expected.to validate_presence_of(:active) }
  end
end
