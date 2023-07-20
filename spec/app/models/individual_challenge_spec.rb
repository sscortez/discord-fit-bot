# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IndividualChallenge, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:registered_user) }
  end

  it 'is valid with valid attributes' do
    expect(create(:individual_challenge)).to be_valid
  end

  describe 'validations' do
    subject { build(:individual_challenge) }

    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:month_year) }
    it { is_expected.to validate_presence_of(:monthly_goal_count) }

    context 'when month_year is invalid' do
      it 'is expected to raise an error' do
        expect do
          create(:individual_challenge, month_year: '50-5000')
        end.to raise_error(ActiveRecord::RecordInvalid, /\b#{I18n.t('month_year_validation_message')}\b/)
      end
    end
  end
end
