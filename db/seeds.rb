# frozen_string_literal: true

require 'development_and_test_seeder'

DevelopmentAndTestSeeder.new.call if %w[development test].include?(Rails.env)
