# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Guild, type: :model do
  describe "associations" do
    it { should have_many(:users) }
    it { should have_many(:registered_users) }
  end

  it 'is valid with valid attributes' do
    expect(create(:guild)).to be_valid
  end

  describe 'validations' do
    subject { build(:guild) }

    it { should validate_presence_of(:discord_guild_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:meta_data) }
  end
end
