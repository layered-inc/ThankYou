source 'https://rubygems.org'
ruby '2.6.4'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
# gem 'rails', '~> 5.2'
gem 'rails', '~> 6.0.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "bootstrap-sass", ">= 3.4.1"
gem 'jquery-rails'
gem 'jquery-validation-rails'
gem 'rails-i18n'

# Use Puma as the app server
gem 'puma', '~> 3.12'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
#
gem 'devise'

gem 'omniauth'
gem 'omniauth-slack'

# https://github.com/CodeSeven/toastr

gem 'bootstrap-select-rails'
gem 'bootstrap-select-wrapper-rails'
gem "font-awesome-rails"
gem 'kaminari'
# gem 'redcarpet'
gem 'cancancan'
gem 'rails_admin', git: 'https://github.com/sferik/rails_admin.git'
gem 'bootsnap', require: false
gem "redis", "~> 4.0"
gem 'rack-attack'
gem "sentry-raven"

gem 'chart-js-rails'

gem 'webpacker'
gem 'image_processing'

group :development, :test do
  # Adds support for Capybara system testing and selenium driver
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'bullet'
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  # gem 'debase'
  # gem 'ruby-debug-ide'
  gem 'selenium-webdriver'
  gem "binding_of_caller"
end

group :test do
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'poltergeist'
  gem 'launchy'
  gem 'timecop'
  gem 'simplecov'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
end

group :development do
  gem 'annotate'
  gem 'better_errors'
  gem 'listen'
  gem 'rails-footnotes', git: 'https://github.com/rikanu/rails-footnotes.git', branch: 'rails6'
  gem 'rails_best_practices'

  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :production do
  gem 'pg', '~> 0.21.0'
  gem 'rails_12factor'
  gem 'google-analytics-rails'
  gem 'puma_worker_killer'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
