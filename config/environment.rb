require 'bundler/setup'
require 'pry'
require 'colorize'
require 'tty-prompt'
require 'httparty'

Bundler.require

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'db/development.sqlite'
)

ActiveRecord::Base.logger = Logger.new(STDOUT)

require_all 'lib'
require_all 'bin'
