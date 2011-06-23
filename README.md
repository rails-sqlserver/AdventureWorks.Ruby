
# Welcome to Rails

Rails is a web-application framework that includes everything needed to create database-backed web applications according to the Model-View-Control pattern. This application is a direct rip off the of the ASP.NET article [_"Build a Data-Driven Enterprise Web Site in 5 Minutes"_](http://msdn.microsoft.com/da-dk/magazine/gg535665%28en-us%29.aspx). This app is meant to serve as an example of how to connect to legacy SQL Server databases with the latest version of all the tools available. In this case [TinyTDS](https://github.com/rails-sqlserver/tiny_tds), the [ActiveRecord SQL Server Adapter](https://github.com/rails-sqlserver/activerecord-sqlserver-adapter) and of course [Rails](http://rubyonrails.org/) itself! 


# Local Setup

Some basic instructions for getting AdventureWorks.Ruby (on Rails) setup locally for you to play with.

### Install The AdventureWorks Database

Download and install the AdventureWorks database. A link can be found in the article above or a copy can be found in the db/AdventureWorks.bak.zip here locally. Create a "hr" login in SQL Server with a password of "hr". Make the default database AdventureWorks with a default schema of HumanResources. Make sure to also select HumanResourcees as an owned schema while in the user properties for the AdventureWorks database. Give the user some good permissions in order to create tables and/or views. This is required for migrations. I recommend "db_owner". Note, I have only tested this on SQL Server 2008!

### Configure Some Environment Variables

If the host of your AdventureWorks database server is not `loclalhost`, then setup the `ADVENTUREWORKS_HOST` environment variable with the proper host to use. **It is important that you setup the `ADVENTUREWORKS_SA_PASS` which is used in the databases rake tasks to perform development cloning operations needed to recreate the AdventureWorksTest database.**


# Whats To Learn Here?

Below is a series of sections that should be helpful to anyone use the SQL Server adapter. Remember, if you have any questions or feedback, you can ask on our [Google Group](http://groups.google.com/group/rails-sqlserver-adapter) or fork the project and submit pull request.

### Setup Views

I decided to create a set of [views](https://github.com/rails-sqlserver/AdventureWorks.Ruby/tree/master/db/views) that both lowered cased and changed the names of the tables schema for the initial models. You can see how I created these views in our [first migration](https://github.com/rails-sqlserver/AdventureWorks.Ruby/blob/master/db/migrate/20110215024229_create_views.rb) too. None of this was strictly necessary as you can configure ActiveRecord in numerous ways. Case in point this model would have worked for `JobCandidate`.

```ruby
class JobCandidate < ActiveRecord::Base
  set_table_name '[HumanResources].[JobCandidate]'
  set_primary_key 'JobCandidateID'
  ...
end
```
The latest 3.1 version of the adapter also supports a configuration that automatically lower cases all schema reflection. This includes tables, views, column names, etc. All you have to do is set this in a config initializer file.

```ruby
ActiveRecord::ConnectionAdapters::SQLServerAdapter.lowercase_schema_reflection = true
```

### Test Database Tasks

A typical paint point for legacy databases and ActiveRecord is that the real schema can not be represented in the `db/schema.rb` file which is generated when you run migrations. This could be due to vendor specific data types, views, user defined functions, schemas, etc. There are some basic steps to overcome this. The first is to tell ActiveRecord to not generate a `schema.rb` by setting this in a config initializer file `ActiveRecord::Base.schema_format = :sql`.

At this point migrations will no longer generate a schema file. Other db related tasks in the Rails databases.rake file will need to be completely over ridden so we can fill in the steps specific to our database to reproduce it. By default, ruby's rake library does not allow you to over ride methods/tasks. So we are going to use little hack @MetaSkills came up with [that allows us to over ride a rake task](https://github.com/rails-sqlserver/AdventureWorks.Ruby/blob/master/lib/override_task.rb). Assuming that is loaded from your lib folder, here is a basic plan of what tasks we are going to over ride in our own `lib/tasks/databases.rake` file.

```ruby
require 'override_task'

namespace :db do
  namespace :structure do
    override_task :dump => :environment do
      # Dump structure DDL file of current Rails env to db/#{Rails.env}_structure.sql
    end
  end
  namespace :test do
    override_task :clone_structure => [ "db:structure:dump", "db:test:purge" ] do
      # Use structure DDL file from db:structure:dump task, build test database...
    end
    override_task :purge => :environment do
      # Create a new empty test database...
    end
  end
end
```
You can [see the complete databases.rake](https://github.com/rails-sqlserver/AdventureWorks.Ruby/blob/master/lib/tasks/databases.rake) file we have built. It includes a complicated `:clone_structure` task since rebuilding the AdventureWorksTest database has to be done in a specific order. This addresses things like complex foreign key constraints and schemas (amount other things) present in the AdventureWorks database. Go legacy! The task also imports all the schema migration information into the tests database as a way to check if the test database has been built already. We do this because cloning the development database is an expensive and time consuming tasks. So we only do it when we need to or force it using the `:clone_force` task we made.

### POSIX Development

If your on a unix'y platform you may be wondering how these `smoscript` and `sqlcmd` binaries would work. Most users that develop with SQL Server are on something other than windows. The typical setup to to have SSH access to your windows box via something like cygwyn and to issue any commands remotely. To make this easy, I have created two bin wrappers that pipe the sqlcmd and smoscript commands via SSH to your windows database box. Make sure to use the same name for your ssh config to that bas as the same name used for the `ADVENTUREWORKS_HOST` environment variable. Assuming that all lines up, these should work.

    $ ln -s /repos/myrojects/AdventureWorks.Ruby/db/bin/sqlcmd /usr/local/bin/sqlcmd
    $ ln -s /repos/myrojects/AdventureWorks.Ruby/db/bin/smoscript /usr/local/bin/smoscript


# Work In Progress

There is still a work todo for final web application. Just started on building the Employee admin interface and need to add some tests too.


# Questions & Contributions

* [Our Google Group](http://groups.google.com/group/rails-sqlserver-adapter)
* [How To Fork A Repo](http://help.github.com/fork-a-repo/)
* [Donations](http://pledgie.com/campaigns/15531)


