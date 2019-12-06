source 'http://rubygems.org'
git_source(:github) { |repo| "http://github.com/#{repo}.git" }

ruby '2.6.1'

gem 'active_model_serializers'
gem 'acts_as_follower', github: 'tcocca/acts_as_follower', branch: 'master'
gem 'acts_as_votable', '~> 0.11.1'
gem 'bcrypt', '~> 3.1.7'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'cancancan'
gem 'carrierwave'
gem 'carrierwave-base64'
gem 'cloudinary'
gem 'dotenv-rails', '~> 2.1', '>= 2.1.1'
gem 'knock', '~> 2.1', '>= 2.1.1'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 3.12'
gem 'rack-attack'
gem 'rack-cors'
gem 'rails', '~> 5.2.3'
gem 'redis', '~> 4.0'
gem 'searchkick'
gem 'sidekiq-scheduler'
gem 'whenever', require: false
gem 'will_paginate', '~> 3.1.0'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'rspec-json_expectations'
  gem 'rspec-rails', '~> 3.5'
end

group :test do
  gem 'database_cleaner'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'ffaker'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
