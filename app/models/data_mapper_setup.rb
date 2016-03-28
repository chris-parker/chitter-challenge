require 'data_mapper'
require 'dm-postgres-adapter'

require_relative 'user'

connection_string = "postgres://localhost/bookmark_manager_#{ENV['RACK_ENV']}"
DataMapper.setup(:default, ENV['DATABASE_URL'] || connection_string)
DataMapper.finalize
