source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.6'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.15'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the Base under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
gem 'capistrano-rails', group: :development
gem 'capistrano-git-with-submodules', '~> 2.0', :github => 'ekho/capistrano-git-with-submodules'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  # gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'letter_opener'
end

group :production, :staging do
  gem 'heroku_rails_deflate'
  gem 'rails_12factor'
  gem 'sprockets', '>= 3.0.0'
  gem 'sprockets-es6'
end

gem "haml-rails", "~> 0.9"

gem 'grape', '~> 0.9.0'
gem 'grape-swagger', '~> 0.8.0'
gem 'grape-swagger-rails', git: 'https://github.com/ruby-grape/grape-swagger-rails'
gem 'rack-cors', :require => 'rack/cors'

gem 'devise'
gem 'devise-token_authenticatable'
gem 'acts_as_api', '~> 0.4.2'

gem "browserify-rails"

gem 'activeadmin', github: 'activeadmin'

gem 'angular-rails-templates'

gem 'faye-rails', '~> 2.0'

gem 'thin'

gem "paranoia", "~> 2"

gem 'bootstrap-datepicker-rails'

gem 'vkontakte_api', '~> 1.4'
gem 'dotenv-rails'
gem "feedjira"
gem 'delayed_job_active_record'

gem 'fullcalendar-rails'
gem 'momentjs-rails'

gem 'just-datetime-picker', '~> 0.0.7'

gem 'irwi', :git => 'git://github.com/alno/irwi.git'
gem 'bluecloth'
gem 'will_paginate'
gem 'will_paginate-bootstrap', '~> 1.0'

gem 'bootstrap-sass', '~> 3.3.6'

gem 'slack-notifier'

gem 'net-ssh', '~> 4.2'
gem 'carrierwave'
gem 'fog', '~> 1.38'

gem 'figaro'

gem 'puma' #Should already be in your Gemfile

gem 'passenger'

group :development do

  gem 'capistrano', '~> 3.4'

  gem 'capistrano-puma'

  gem 'capistrano-bundler'

  gem 'capistrano-rvm'

  gem 'capistrano-passenger'

  gem 'capistrano-figaro-yml'

  gem 'capistrano-postgresql'
end
