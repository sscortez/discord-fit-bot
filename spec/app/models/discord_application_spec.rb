# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DiscordApplication, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:application_commands) }
  end

  it 'is valid with valid attributes' do
    expect(create(:discord_application)).to be_valid
  end

  describe 'validations' do
    subject { build(:discord_application) }

    it { is_expected.to validate_presence_of(:discord_application_id) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:meta_data) }

    it { is_expected.to validate_uniqueness_of(:discord_application_id) }
  end
end
