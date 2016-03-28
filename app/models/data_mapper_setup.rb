require 'data_mapper'
require 'dm-postgres-adapter'

require_relative 'user'
require_relative 'peep'

connection_string = "postgres://localhost/chitter_#{ENV['RACK_ENV']}"
DataMapper.setup(:default, ENV['DATABASE_URL'] || connection_string)
DataMapper.finalize
