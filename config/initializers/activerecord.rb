
ActiveRecord::Base.table_name_prefix = 'HumanResources.'
ActiveRecord::Base.schema_format = :sql

ActiveRecord::ConnectionAdapters::SQLServerAdapter.enable_default_unicode_types = true
ActiveRecord::ConnectionAdapters::SQLServerAdapter.log_info_schema_queries = true


