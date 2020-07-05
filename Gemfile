source 'https://rubygems.org'

ruby '2.6.6'

gem 'rails', '5.2.4.3'

group :development, :test do
  gem 'rspec-rails', '~> 4.0.0'
  gem 'bullet', '~> 6.1.0'   # notify n+1 queries
end

gem 'pg'

group :test do
  gem 'factory_bot_rails', '~> 6.0.0'
  gem 'cucumber-rails', '2.1.0', :require => false
  gem 'database_cleaner', '~> 1.8.0'
  gem 'minitest'
  gem 'shoulda-matchers', '4.3.0'
  gem 'rails-controller-testing', '1.0.2'    # rails 5.0.0
  gem 'simplecov', :require => false
end

group :production do
  gem 'rails_12factor'
end

gem 'will_paginate', '~> 3.3.0'
gem 'will_paginate-bootstrap'

gem 'thin', '~> 1.7.0'

gem 'sass-rails',   '~> 5.0.0'
gem 'bootstrap-sass', '~> 3.4.1'

gem 'uglifier', '~> 4.2.0'

gem 'jquery-rails', '~> 4.4.0'

gem 'twitter', '7.0.0'

group :development do
  gem 'better_errors', '~> 2.7.0'
  gem 'binding_of_caller', '0.8.0'
  gem 'meta_request', '~> 0.7.0'  # used for rails chrome extension
  gem 'web-console'
end
