source 'https://rubygems.org'
ruby "2.0.0"
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0.rc1'

# Use sqlite3 as the database for Active Record
#gem 'sqlite3'

# Use mysql as the database for Active Record
# for rails 3 ,it should be mysql2
gem 'mysql2'

#this must be installed unless the annotation doesn't work
gem 'protected_attributes'

gem 'bootstrap-sass'

gem 'bcrypt-ruby'

#Allow the user to make sample users with semi-realistic names and email addresses 
gem 'faker'

#Allow us to paginate the users, so that only the some will show up in one page ( could be change later)
gem 'will_paginate'
gem 'bootstrap-will_paginate'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0.rc1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'jquery-ui-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.0.1'
gem 'jquery-fileupload-rails'
gem 'carrierwave'
gem 'mini_magick'
#Most Rails applications use forms; most Rails developers use a form builder gem 
#to simplify and improve upon the default Rails form helpers. 
#Twitter Bootstrap provides styling for forms.
gem 'simple_form'

#notification systems
gem 'public_activity'
# annotations aren’t needed in production applications.) 
#We next install it with bundle install:
#$ bundle install
#This gives us a command called annotate, which simply adds comments 
#containing the data model to the model file:
#$ bundle exec annotate
group :development do
	gem 'annotate'
	gem 'htmlbeautifier'
end

group :production do
  #used for heruku,product deployment
  gem 'pg', '0.15.1'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

#validate datetime by 
gem 'validates_timeliness', '~> 3.0'

#group :test do
#   gem 
#	gem 'factory_girl_rails'
#end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
