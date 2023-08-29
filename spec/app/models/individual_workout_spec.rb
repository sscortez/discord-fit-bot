# frozen_string_literal: true

require 'rails_helper'

RSpec.describe IndividualWorkout, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:registered_user) }
  end

  it 'is valid with valid attributes' do
    expect(create(:individual_workout)).to be_valid
  end

  describe 'validations' do
    subject { build(:individual_workout) }

    it { is_expected.to validate_presence_of(:workout_date) }
    it { is_expected.to validate_presence_of(:month_year) }
    it { is_expected.to validate_presence_of(:duration_mins) }

    context 'when month_year is invalid' do
      it 'is expected to raise an error' do
        expect do
          create(:individual_workout, month_year: '50-5000')
        end.to raise_error(ActiveRecord::RecordInvalid, /\b#{I18n.t('month_year_validation_message')}\b/)
      end
    end
  end
end
