# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RegisteredUsers::Unregister do
  describe '#new' do
    context 'when user_id and guild_id are provided' do
      let(:registered_user) { create(:registered_user) }

      it 'creates a new instantiation of class' do
        expect do
          described_class.new(registered_user)
        end.not_to raise_error
      end
    end

    context 'when no argument is passed' do
      it 'raises ArgumentError' do
        expect do
          described_class.new
        end.to raise_error(ArgumentError)
      end
    end
  end

  describe '#call' do
    context 'when a RegisteredUser record is passed' do
      let(:registered_user) { create(:registered_user) }

      it 'deletes the record from the table' do
        result = described_class.new(registered_user).call

        expect(result.destroyed?).to be true
      end
    end
  end
end
