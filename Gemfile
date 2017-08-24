source 'https://rubygems.org'

ruby '2.4.1'

gem 'rails', '5.1.3'

group :development, :test do
  gem 'rspec-rails', '~> 3.6.0'
  gem 'bullet', '~> 5.6.0'   # notify n+1 queries
end

gem 'pg'

group :test do
  gem 'factory_girl_rails', '~> 4.8.0'
  gem 'cucumber-rails', '1.5.0', :require => false
  gem 'database_cleaner', '~> 1.6.0'
  gem 'minitest'
  gem 'shoulda-matchers', '3.1.2'
  gem 'rails-controller-testing', '1.0.2'    # rails 5.0.0
end

group :production do
  gem 'rails_12factor'
end

gem 'will_paginate', '~> 3.1.6'
gem 'will_paginate-bootstrap'

gem 'thin', '~> 1.7.0'

gem 'sass-rails',   '~> 5.0.0'
gem 'bootstrap-sass', '~> 3.3.7'

gem 'uglifier', '~> 3.2.0'

gem 'jquery-rails', '~> 4.2.0'

gem 'twitter', '5.16.0'

group :development do
  gem 'better_errors', '~> 2.3.0'
  gem 'binding_of_caller', '0.7.2'
  gem 'meta_request', '~> 0.4.3'  # used for rails chrome extension
end
