require 'override_task'

namespace :db do

  namespace :structure do

    override_task :dump => :environment do
      abcs = ActiveRecord::Base.configurations
      `smoscript -s #{abcs[Rails.env]['host']} -d #{abcs[Rails.env]['database']} -u #{abcs[Rails.env]['username']} -p #{abcs[Rails.env]['password']} -f db\\#{Rails.env}_structure.sql -A -U`
    end

  end

  namespace :test do

    override_task :clone_structure => [ "db:structure:dump", "db:test:purge" ] do
      abcs = ActiveRecord::Base.configurations
      `sqlcmd -S #{abcs['test']['host']} -d #{abcs['test']['database']} -U #{abcs['test']['username']} -P #{abcs['test']['password']} -i db\\#{Rails.env}_structure.sql`
    end

    override_task :purge => :environment do
      abcs = ActiveRecord::Base.configurations
      test = abcs.deep_dup['test']
      test_database = test['database']
      test['database'] = 'master'
      ActiveRecord::Base.establish_connection(test)
      ActiveRecord::Base.connection.recreate_database!(test_database)
    end

  end

end