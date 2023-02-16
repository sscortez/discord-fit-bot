# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationCommandType, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:application_commands) }
  end

  it 'is valid with valid attributes' do
    expect(create(:application_command_type)).to be_valid
  end

  describe 'validations' do
    subject { build(:application_command_type) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
