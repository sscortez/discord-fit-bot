# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationCommand, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:discord_application) }
    it { is_expected.to belong_to(:application_command_type) }
  end

  it 'is valid with valid attributes' do
    expect(create(:application_command)).to be_valid
  end

  describe 'validations' do
    subject { build(:application_command) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:meta_data) }

    it { is_expected.to validate_uniqueness_of(:discord_application_command_id) }
    it { is_expected.to have_db_index(%i[discord_application_id discord_application_command_id]).unique(true) }
  end
end
