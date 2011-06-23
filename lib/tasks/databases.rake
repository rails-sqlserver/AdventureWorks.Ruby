require 'override_task'

namespace :db do
  
  namespace :structure do

    override_task :dump => :environment do
      if test_database_needs_migrations?
        puts "-- Dumping #{Rails.env} structure..."
        abcs = ActiveRecord::Base.configurations
        `smoscript -s #{abcs[Rails.env]['host']} -d #{abcs[Rails.env]['database']} -u sa -p #{ENV['ADVENTUREWORKS_SA_PASS']} -F db\\ -i -A -U`
        `smoscript -s #{abcs[Rails.env]['host']} -d #{abcs[Rails.env]['database']} -u sa -p #{ENV['ADVENTUREWORKS_SA_PASS']} -f db\\#{Rails.env}_structure.sql -i -A -U`
      end
    end

  end

  namespace :test do
    
    desc "Force recreate the test databases from the development structure"
    task :clone_force => :environment do
      force_test_database_needs_migrations { Rake::Task["db:test:clone"].execute }
    end
    
    override_task :clone_structure => [ "db:structure:dump", "db:test:purge" ] do
      if test_database_needs_migrations?
        puts "-- Cloning test structure..."
        test = ActiveRecord::Base.configurations['test']
        ordered_ddl_files = [
          "Schema\\HumanResources.sql", 
          "Schema\\Person.sql", 
          "Schema\\Production.sql", 
          "Schema\\Purchasing.sql", 
          "Schema\\Sales.sql", 
          "UserDefinedDataType\\dbo.AccountNumber.sql", 
          "UserDefinedDataType\\dbo.Flag.sql", 
          "UserDefinedDataType\\dbo.Name.sql", 
          "UserDefinedDataType\\dbo.NameStyle.sql", 
          "UserDefinedDataType\\dbo.OrderNumber.sql", 
          "UserDefinedDataType\\dbo.Phone.sql", 
          "UserDefinedFunction\\dbo.ufnGetAccountingEndDate.sql", 
          "UserDefinedFunction\\dbo.ufnGetAccountingStartDate.sql", 
          "UserDefinedFunction\\dbo.ufnGetContactInformation.sql", 
          "UserDefinedFunction\\dbo.ufnGetDocumentStatusText.sql", 
          "UserDefinedFunction\\dbo.ufnGetProductDealerPrice.sql", 
          "UserDefinedFunction\\dbo.ufnGetProductListPrice.sql", 
          "UserDefinedFunction\\dbo.ufnGetProductStandardCost.sql", 
          "UserDefinedFunction\\dbo.ufnGetPurchaseOrderStatusText.sql", 
          "UserDefinedFunction\\dbo.ufnGetSalesOrderStatusText.sql", 
          "UserDefinedFunction\\dbo.ufnGetStock.sql", 
          "UserDefinedFunction\\dbo.ufnLeadingZeros.sql", 
          "XmlSchemaCollection\\HumanResources.HRResumeSchemaCollection.sql", 
          "XmlSchemaCollection\\Person.AdditionalContactInfoSchemaCollection.sql", 
          "XmlSchemaCollection\\Production.ManuInstructionsSchemaCollection.sql", 
          "XmlSchemaCollection\\Production.ProductDescriptionSchemaCollection.sql", 
          "XmlSchemaCollection\\Sales.IndividualSurveySchemaCollection.sql", 
          "XmlSchemaCollection\\Sales.StoreSurveySchemaCollection.sql", 
          "Table\\HumanResources.Department.sql", 
          "Table\\Person.Contact.sql", 
          "Table\\Person.CountryRegion.sql", 
          "Table\\Sales.SalesTerritory.sql", 
          "Table\\Person.StateProvince.sql", 
          "Table\\Person.Address.sql", 
          "Table\\HumanResources.Shift.sql", 
          "Table\\Production.ProductModel.sql", 
          "Table\\Production.ProductCategory.sql", 
          "Table\\Production.ProductSubcategory.sql", 
          "Table\\Production.UnitMeasure.sql", 
          "Table\\Production.Product.sql", 
          "StoredProcedure\\dbo.uspGetBillOfMaterials.sql", 
          "StoredProcedure\\dbo.uspGetEmployeeManagers.sql", 
          'StoredProcedure\\dbo.uspGetManagerEmployees.sql', 
          "StoredProcedure\\dbo.uspGetWhereUsedProductID.sql", 
          "StoredProcedure\\dbo.uspPrintError.sql", 
          "StoredProcedure\\dbo.uspLogError.sql", 
          "StoredProcedure\\HumanResources.uspUpdateEmployeeHireInfo.sql", 
          "StoredProcedure\\HumanResources.uspUpdateEmployeeLogin.sql", 
          "StoredProcedure\\HumanResources.uspUpdateEmployeePersonalInfo.sql", 
          "Table\\Purchasing.Vendor.sql", 
          "Table\\HumanResources.Employee.sql", 
          "Table\\Purchasing.ShipMethod.sql", 
          "Table\\Purchasing.PurchaseOrderHeader.sql", 
          "Table\\Sales.CreditCard.sql", 
          "Table\\Sales.Currency.sql", 
          "Table\\Sales.Customer.sql",
          "Table\\Sales.CurrencyRate.sql", 
          "Table\\Sales.SalesPerson.sql", 
          "Table\\Sales.SalesOrderHeader.sql", 
          "Table\\Sales.SpecialOffer.sql", 
          "Table\\Sales.SpecialOfferProduct.sql", 
          "Table\\Sales.SalesReason.sql", 
          "development_structure.sql"
        ]
        ordered_ddl_files.each do |file|
          `sqlcmd -S #{test['host']} -d #{test['database']} -U sa -P #{ENV['ADVENTUREWORKS_SA_PASS']} -i \"db\\#{file}\"`
        end
        copy_schema_migrations
      end
    end

    override_task :purge => :environment do
      if test_database_needs_migrations?
        puts "-- Creating fresh test database..."
        test = ActiveRecord::Base.configurations['test']
        `sqlcmd -S #{test['host']} -d master -U sa -P #{ENV['ADVENTUREWORKS_SA_PASS']} -Q "DROP DATABASE #{test['database']}"`
        `sqlcmd -S #{test['host']} -d master -U sa -P #{ENV['ADVENTUREWORKS_SA_PASS']} -Q "CREATE DATABASE #{test['database']}"`
        `sqlcmd -S #{test['host']} -d #{test['database']} -U sa -P #{ENV['ADVENTUREWORKS_SA_PASS']} -Q "CREATE USER [#{test['username']}] FOR LOGIN [#{test['username']}] WITH DEFAULT_SCHEMA=[HumanResources]"`
      end
    end

  end

end



def force_test_database_needs_migrations
  @force_test_database_needs_migrations = true
  yield
ensure
  @force_test_database_needs_migrations = false
end

def test_database_needs_migrations?
  return true if @force_test_database_needs_migrations
  return @test_database_needs_migrations unless @test_database_needs_migrations.nil?
  ActiveRecord::Base.establish_connection(:test)
  @test_database_needs_migrations = ActiveRecord::Migrator.new(:up,'db/migrate').pending_migrations.present? rescue true
end

def copy_schema_migrations
  puts "-- Copying Schema Migrations..."
  schema_table = ActiveRecord::Migrator.schema_migrations_table_name
  ActiveRecord::Base.establish_connection(:development)
  versions = ActiveRecord::Base.connection.select_values("SELECT version FROM #{schema_table}").map(&:to_i).sort
  ActiveRecord::Base.establish_connection(:test)
  versions.each do |version|
    ActiveRecord::Base.connection.insert("INSERT INTO #{schema_table} (version) VALUES ('#{version}')")
  end
end

