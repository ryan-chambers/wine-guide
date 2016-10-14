source 'https://rubygems.org'

ruby '2.2.0'

gem 'rails', '= 4.2.7.1'

group :development, :test do
  gem 'rspec-rails', '~> 3.5.2'
  gem 'bullet', '5.4.2'   # notify n+1 queries
end

gem 'pg', '0.19.0'

group :test do
  gem 'factory_girl_rails', '~> 4.7.0'
  gem 'cucumber-rails', '1.4.5', :require => false
  gem 'database_cleaner', '~> 1.5.0'
  gem 'minitest'
  gem 'shoulda-matchers'
end

group :production do
  gem 'rails_12factor'
end

gem 'will_paginate', '~> 3.0'
gem 'will_paginate-bootstrap'

gem 'thin', '~> 1.7'

gem 'sass-rails',   '~> 5.0.0'
gem 'coffee-rails', '~> 4.1.0'  # is this really needed?
gem 'bootstrap-sass', '~> 3.3.7'

gem 'uglifier', '>= 1.3.0'

gem 'jquery-rails', '~> 4.2.0'

gem 'twitter', '5.16.0'

group :development do
  gem 'better_errors', '2.1.1'
  gem 'binding_of_caller', '0.7.2'
  gem 'meta_request', '~> 0.4.0'  # used for rails chrome extension
end
