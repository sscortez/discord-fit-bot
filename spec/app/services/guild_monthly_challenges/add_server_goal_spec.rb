# frozen_string_literal: true

require 'rails_helper'
require 'discord_client'

RSpec.describe GuildMonthlyChallenges::AddServerGoal do
  subject { described_class }

  describe '#new' do
    context 'when enough arguments are passed' do
      it 'creates a new instantiation of the class' do
        expect do
          subject.new('some_guild_id', '07-2023', 5)
        end.not_to raise_error
      end
    end

    context 'when not enough arguments are passed' do
      it 'raises ArgumentError' do
        expect do
          subject.new('some_guild_id')
        end.to raise_error(ArgumentError)
      end
    end
  end

  describe '#call' do
    context 'when valid arguments are passed' do
      fit 'creates a new guild monthly challenge record' do
        guild = create(:guild)

        expect do
          subject.new(guild.id, '07-2023', 5).call
        end.to change(GuildMonthlyChallenge, :count).by(1)
      end
    end

    context 'when invalid month-year value is passed' do
      it 'raises an error' do
        guild = create(:guild)

        expect do
          subject.new(
            guild.id,
            'bad date',
            5
          ).call
        end.to raise_error(ActiveRecord::RecordInvalid, /\b#{I18n.t('month_year_validation_message')}\b/)
      end
    end
  end
end
