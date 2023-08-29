# frozen_string_literal: true

require 'rails_helper'
require 'discord_client'

RSpec.describe IndividualWorkouts::AddIndividualWorkout do
  describe '#new' do
    context 'when enough arguments are passed' do
      it 'creates a new instantiation of the class' do
        expect do
          described_class.new('some_registered_user_id', Time.zone.today, 1)
        end.not_to raise_error
      end
    end

    context 'when not arguments are passed' do
      it 'raises ArgumentError' do
        expect do
          described_class.new('some_registered_user_id')
        end.to raise_error(ArgumentError)
      end
    end
  end

  describe '#call' do
    context 'when valid arguments are passed' do
      it 'creates a new individual workout record' do
        registered_user = create(:registered_user)

        expect do
          described_class.new(
            registered_user.id,
            Time.zone.today,
            3
          ).call
        end.to change(IndividualWorkout, :count).by(1)
      end
    end

    context 'when invalid date is passed' do
      it 'raises an error' do
        registered_user = create(:registered_user)

        expect do
          described_class.new(
            registered_user.id,
            'bad date',
            3
          ).call
        end.to raise_error(NoMethodError, /strftime/)
      end
    end
  end
end
