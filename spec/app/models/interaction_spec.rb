# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Interaction, type: :model do
  it 'is valid with valid attributes' do
    expect(create(:interaction)).to be_valid
  end

  it 'is not valid without a service_name' do
    expect do
      interaction = build(:interaction, service_name: nil)
      interaction.save!
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'is not valid without a type' do
    expect do
      interaction = build(:interaction, type: nil)
      interaction.save!
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'is not valid without a timestamp' do
    expect do
      interaction = build(:interaction, timestamp: nil)
      interaction.save!
    end.to raise_error(ActiveRecord::RecordInvalid)
  end

  it 'is not valid without a meta_data' do
    expect do
      interaction = build(:interaction, meta_data: nil)
      interaction.save!
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
end
