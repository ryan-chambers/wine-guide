source 'https://rubygems.org'

ruby '2.6.3'

gem 'rails', '5.2.4.2'

group :development, :test do
  gem 'rspec-rails', '~> 3.8.0'
  gem 'bullet', '~> 5.7.6'   # notify n+1 queries
end

gem 'pg'

group :test do
  gem 'factory_bot_rails', '~> 4.11.0'
  gem 'cucumber-rails', '1.8.0', :require => false
  gem 'database_cleaner', '~> 1.7.0'
  gem 'minitest'
  gem 'shoulda-matchers', '3.1.2'
  gem 'rails-controller-testing', '1.0.2'    # rails 5.0.0
  gem 'simplecov', :require => false
end

group :production do
  gem 'rails_12factor'
end

gem 'will_paginate', '~> 3.1.6'
gem 'will_paginate-bootstrap'

gem 'thin', '~> 1.7.0'

gem 'sass-rails',   '~> 5.0.0'
gem 'bootstrap-sass', '~> 3.4.1'

gem 'uglifier', '~> 4.1.0'

gem 'jquery-rails', '~> 4.3.3'

gem 'twitter', '6.2.0'

group :development do
  gem 'better_errors', '~> 2.4.0'
  gem 'binding_of_caller', '0.8.0'
  gem 'meta_request', '~> 0.6.0'  # used for rails chrome extension
end
