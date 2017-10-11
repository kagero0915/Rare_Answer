# A sample Gemfile
source "https://rubygems.org"

gem 'rake'
gem 'sinatra'
gem 'sinatra-contrib'
gem "activerecord", "< 5.0.0"
gem 'sinatra-activerecord'
group :development do
  gem 'sqlite3'
  gem 'racksh'
  gem 'pry-byebug' # デバッグを実施(Ruby 2.0以降で動作する)
end

group :production do
  gem 'pg'
end

gem 'bcrypt'