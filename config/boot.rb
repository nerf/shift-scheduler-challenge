env = ENV['SOHO_ENV'] ||= 'production'

require 'rubygems'
require 'bundler/setup'
Bundler.require(env.to_sym)
require 'yaml'
require 'active_record'

database_config = YAML.load(File.read('config/database.yml'))
ActiveRecord::Base.establish_connection(database_config[env])

require './db/schema.rb'

Dir["./app/**/*.rb"].each { |file| require file }
