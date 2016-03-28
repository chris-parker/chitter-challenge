require 'data_mapper'
require './app/app.rb'

namespace :db do
  desc "Non-destructive update"
  task :auto_upgrade do
    DataMapper.auto_upgrade!
    puts "Auto-upgrade complete (no data loss)"
  end

  desc "Destructive update"
  task :auto_migrate do
    DataMapper.auto_migrate!
    puts "Auto-migrate complete (data was lost)"
  end
end
