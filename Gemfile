# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.2.0'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.4'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'discordrb', '~> 3.4.0'

gem 'ed25519', '~> 1.3.0'

gem 'faraday', '~> 2.7.4'

gem 'sidekiq', '~> 7.0.3'

gem 'redis-rails', '~> 5.0.2'

gem 'jsbundling-rails', '~> 1.1.1'

gem 'rspec-rails', '~> 6.0.1'

gem 'rubocop-rails', '~> 2.17.4'

gem 'rubocop-rspec', '~> 2.18.1'

gem 'shoulda-matchers', '~> 5.3.0'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]

  gem 'dotenv-rails', '~> 2.8.1'

  gem 'factory_bot_rails', '~> 6.2.0'

  gem 'pry', '~> 0.14.2'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
