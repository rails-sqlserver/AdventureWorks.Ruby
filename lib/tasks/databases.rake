require 'override_task'

namespace :db do

  namespace :structure do

    override_task :dump => :environment do
      abcs = ActiveRecord::Base.configurations
      `smoscript -s #{abcs[Rails.env]['host']} -d #{abcs[Rails.env]['database']} -u sa -p #{ENV['ADVENTUREWORKS_SA_PASS']} -F db\\ -i -A -U`
      `smoscript -s #{abcs[Rails.env]['host']} -d #{abcs[Rails.env]['database']} -u sa -p #{ENV['ADVENTUREWORKS_SA_PASS']} -f db\\#{Rails.env}_structure.sql -i -A -U`
    end

  end

  namespace :test do

    override_task :clone_structure => [ "db:structure:dump", "db:test:purge" ] do
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
    end

    override_task :purge => :environment do
      test = ActiveRecord::Base.configurations['test']
      `sqlcmd -S #{test['host']} -d master -U sa -P #{ENV['ADVENTUREWORKS_SA_PASS']} -Q "DROP DATABASE #{test['database']}"`
      `sqlcmd -S #{test['host']} -d master -U sa -P #{ENV['ADVENTUREWORKS_SA_PASS']} -Q "CREATE DATABASE #{test['database']}"`
      `sqlcmd -S #{test['host']} -d #{test['database']} -U sa -P #{ENV['ADVENTUREWORKS_SA_PASS']} -Q "CREATE USER [#{test['username']}] FOR LOGIN [#{test['username']}] WITH DEFAULT_SCHEMA=[HumanResources]"`
    end

  end

end


