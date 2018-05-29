# frozen_string_literal: true

source "https://rubygems.org"

git_source(:github) {|repo_name| "https://github.com/#{repo_name}" }

gem 'sqlite3'
gem 'activerecord'
gem 'activesupport'
gem 'sinatra'

group :development, :test do
  gem 'rspec'
  gem 'pry'
  gem 'byebug'
end

group :test do
  gem 'factory_bot'
end
