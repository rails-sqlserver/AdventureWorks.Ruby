require 'override_task'

namespace :db do

  namespace :structure do

    override_task :dump => :environment do
      puta "Task not supported by 'sqlserver'"
    end

  end

  namespace :test do

    override_task :clone_structure => [ "db:structure:dump", "db:test:purge" ] do
      
    end

    override_task :purge => :environment do
      abcs = ActiveRecord::Base.configurations
      ActiveRecord::Base.establish_connection(:test)
      begin
        ActiveRecord::Base.connection.recreate_database
      rescue
        ActiveRecord::Base.connection.recreate_database!(abcs["test"]["database"])
      end
    end

  end

end