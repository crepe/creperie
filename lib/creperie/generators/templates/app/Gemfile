# A sample Gemfile
source 'https://rubygems.org'

# Bundle from GitHub, as only a prerelease is currently available.
gem 'crepe', github: 'crepe/crepe'
gem 'rake'

# Creperie provides CLI convenience for your crepe app as well.
gem 'creperie', github: 'crepe/creperie'

# Use ActiveRecord to define models and PostgreSQL to store them.
gem 'activerecord', require: 'active_record'
gem 'pg'

# Use Jsonite to convert objects to JSON for presentation. Place
# presenters in the app/presenters/ directory.
#
# More info: https://github.com/crepe/jsonite
# gem 'jsonite', github: 'crepe/jsonite'

# Use puma as the web server.
# gem 'puma'

group :development, :test do
  gem 'pry'
end

group :test do
  gem 'rspec'
  gem 'rack-test'
end
