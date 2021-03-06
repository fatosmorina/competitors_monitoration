source "https://rubygems.org"

ruby "2.4.0"

gem "autoprefixer-rails"
gem "flutie"
gem "honeybadger"
gem "jquery-rails"
gem "normalize-rails", "~> 3.0.0"
gem "pg"
gem "puma"
gem "rack-canonical-host"
gem "rails", "~> 5.0.0"
gem "recipient_interceptor"
gem "sass-rails", "~> 5.0"
gem "simple_form"
gem "skylight"
gem "sprockets", ">= 3.0.0"
gem "suspenders"
gem "title"
gem "uglifier"
gem 'retryable'
gem 'money-rails', '~>1'
gem 'vacuum', '~> 2.0', '>= 2.0.2'
gem 'sidekiq'
gem 'whenever'
gem 'devise'
gem 'bootstrap-sass'
gem 'cocoon'
gem 'coffee-rails', '~> 4.2', '>= 4.2.2'
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.2'
gem 'jbuilder', '~> 2.7'

group :development do
  gem "listen"
  gem "spring"
  gem "spring-commands-rspec"
  gem "web-console"
end

group :development, :test do
  gem "awesome_print"
  gem "bullet"
  gem "bundler-audit", ">= 0.5.0", require: false
  gem "dotenv-rails"
  gem "factory_girl_rails"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 3.5"
end

group :development, :staging do
  gem "rack-mini-profiler", require: false
end

group :test do
  gem "capybara-webkit"
  gem "database_cleaner"
  gem "formulaic"
  gem "launchy"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "timecop"
  gem "webmock"
  gem "vcr"
  gem 'faker'
  gem 'rspec-sidekiq'
end

group :staging, :production do
  gem "rack-timeout"
end

gem 'high_voltage'
gem 'bourbon', '~> 5.0.0.beta.7'
gem 'neat', '~> 1.8.0.beta.1'
gem 'refills', group: [:development, :test]
