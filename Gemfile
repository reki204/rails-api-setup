# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.3'
gem 'rails', '~> 7.0.3', '>= 7.0.3.1'
gem 'pg', '~> 1.4.3'
gem 'puma', '~> 5.0'
gem 'bcrypt', '~> 3.1.7'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
gem 'bootsnap', require: false

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec'
  gem 'rails_best_practices'
end

group :development do
  gem 'pry-byebug'
  gem 'spring'
end
