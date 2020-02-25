source 'https://rubygems.org'

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 4.2.6'
# Use PostgreSQL as the database for Active Record
gem 'pg', '~> 0.18.4'

# Devise for authentication
gem 'devise', '~> 4.1.0'

# Use SCSS for stylesheets
gem 'sass-rails', require: false
gem 'sassc-rails', '~> 1.2.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Bootstrap & FontAwesome SASS
gem 'bootstrap-sass', '~> 3.3.6'
gem 'font-awesome-sass', '~> 4.6.2'

# FriendlyId for slugging
gem 'friendly_id', '~> 5.1.0'

# Pagination
gem 'kaminari', '~> 0.16.3'
gem 'bootstrap-kaminari-views', '~> 0.0.5'

# Nokogiri for XML generation
gem 'nokogiri', '~> 1.6.7.2'

# CKEditor
gem 'ckeditor', '~> 4.1.6'

# Lightbox
gem 'lightbox2-rails', '2.8.2.1'

# Images
gem 'carrierwave', '~> 0.11.2'
gem 'mini_magick', '~> 4.9.4'

# Fog to upload stuff to S3
gem 'fog-aws', '~> 0.9.2'

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.1.1'

# Use Foreman for process management
gem 'foreman', '~> 0.81.0'

# Rollbar for error reports
gem 'rollbar', '~> 2.11.3'

group :production do
  gem 'rails_12factor', '~> 0.0.3'
  gem 'puma'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  gem 'better_errors', '~> 2.1.1'
  gem 'binding_of_caller', '~> 0.7.2'

  # Use Capistrano for deployment
  # gem 'capistrano-rails'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end
