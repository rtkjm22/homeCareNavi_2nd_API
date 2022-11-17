source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

gem 'active_flag'
gem 'active_storage_validations'
gem 'aws-sdk-s3'
gem 'bootsnap', require: false
gem 'devise-i18n'
gem 'devise_token_auth', '>= 1.2.0', git: 'https://github.com/lynndylanhurley/devise_token_auth'
gem 'discard', '~> 1.2'
gem 'enum_help'
gem 'image_processing'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'rails', '~> 7.0.3', '>= 7.0.3.1'
gem 'rails-i18n'
gem 'ruby-vips'
gem 'silencer'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'bullet'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'gimei'
  gem 'rspec-rails'
end

group :development do
  gem 'letter_opener_web', '~> 2.0'
  gem 'rbs', require: false
  gem 'rbs_rails', require: false
  gem 'rubocop', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
  gem 'steep', require: false
end

group :test do
  gem 'committee-rails'
  gem 'shoulda-matchers'
  gem 'simplecov'
  gem 'vcr'
  gem 'webmock'
end
