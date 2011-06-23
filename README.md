
# Welcome to Rails

Rails is a web-application framework that includes everything needed to create database-backed web applications according to the Model-View-Control pattern. This application is a direct rip off the of the ASP.NET article [_"Build a Data-Driven Enterprise Web Site in 5 Minutes"_](http://msdn.microsoft.com/da-dk/magazine/gg535665%28en-us%29.aspx). This app is meant to serve as an example of how to connect to legacy SQL Server databases with the latest version of all the tools available. In this case [TinyTDS](https://github.com/rails-sqlserver/tiny_tds), the [ActiveRecord SQL Server Adapter](https://github.com/rails-sqlserver/activerecord-sqlserver-adapter) and of course [Rails](http://rubyonrails.org/) itself! 


# Local Setup

Some basic instructions for getting AdventureWorks.Ruby (on Rails) setup locally for you to play with.

## Install The AdventureWorks Database

Download and install the AdventureWorks database. A link can be found in the article above or a copy can be found in the db/AdventureWorks.bak.zip here locally. Create a "hr" login in SQL Server with a password of "hr". Make the default database AdventureWorks with a default schema of HumanResources. Make sure to also select HumanResourcees as an owned schema while in the user properties for the AdventureWorks database. Give the user some good permissions in order to create tables and/or views. This is required for migrations. I recommend "db_owner". Note, I have only tested this on SQL Server 2008!

## Configure Some Environment Variables

If the host of your AdventureWorks database server is not `loclalhost`, then setup the `ADVENTUREWORKS_HOST` environment variable with the proper host to use. **It is important that you setup the `ADVENTUREWORKS_SA_PASS` which is used in the databases rake tasks to perform development cloning operations needed to recreate the AdventureWorksTest database.**




  

# Noteworthy

We created a config/initializers/activerecord.rb file that holds two optional configurations. One for the table name prefix to match our default schema. This way we can keep our table name configurations to a minimal in our models. We also added a configuration option for the SQL Server adapter to enable newly created string columns as unicode/national types. This only affects newly created columns via migrations. So if you specify a :string type, you will get nvarchar(255) vs varchar(255).

  $ rake db:migrate


  class JobCandidate < ActiveRecord::Base
    set_table_name '[HumanResources].[JobCandidate]'
    set_primary_key 'JobCandidateID'
    ...
  end


* The override_task.rb file in lib.
  https://github.com/rails-sqlserver/activerecord-sqlserver-adapter/wiki/Rails-DB-Rake-Tasks
  http://metaskills.net/2010/05/26/the-alias_method_chain-of-rake-override-rake-task/

* Setup views
  - All [ModifiedDate] to [updated_at]

* Force lowercase with adapter?

* ActiveRecord::Base.schema_format = :sqlserver


# Contribute Back




