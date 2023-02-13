# frozen_string_literal: true

require 'rails_helper'
require 'development_and_test_seeder'

RSpec.describe DevelopmentAndTestSeeder do
  describe '#call' do
    let(:rake) do
      rake = instance_double(Rake::Task)

      allow(Rake::Task).to receive(:[]).and_return(rake)
      allow(rake).to receive(:invoke).and_return(true)

      rake
    end

    it "invokes the 'discord_applications:seed_application_command_types' rake task" do
      rake

      described_class.new.call

      expect(Rake::Task).to have_received(:[]).with('discord_applications:seed_application_command_types').once
      expect(rake).to have_received(:invoke).exactly(1).times
    end
  end
end
