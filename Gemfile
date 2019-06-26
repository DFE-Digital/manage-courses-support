source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby '2.6.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

# PostgreSQL database
gem 'pg'

# Use Puma as the app server
gem 'puma', '~> 4.0'

# Use SCSS for stylesheets
gem 'autoprefixer-rails'
gem 'sassc-rails'

# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'

# Manage multiple processes i.e. web server and webpack
gem 'foreman'

gem 'bootsnap', '>= 1.1.0'
gem 'jbuilder', '~> 2.9'
gem 'json'
gem 'pkg-config', '~> 1.3'
gem 'rake'

# Parsing JSON from an API
gem 'json_api_client'

# For encoding/decoding web token used for authentication
gem 'jwt'

# Settings for the app
gem 'config'

# App Insights for Azure
gem 'application_insights'

# Sentry
gem 'sentry-raven'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'govuk-lint', '~> 3.11'
  gem 'pry-byebug'
  gem 'rspec-rails'
end

group :test do
  gem 'capybara'
  gem "rspec_junit_formatter"
  gem 'webmock'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end
