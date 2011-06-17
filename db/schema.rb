# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110215024229) do

  create_table "AWBuildVersion", :id => false, :force => true do |t|
  end

  create_table "Address", :id => false, :force => true do |t|
  end

  create_table "AddressType", :id => false, :force => true do |t|
  end

  create_table "BillOfMaterials", :id => false, :force => true do |t|
  end

  create_table "Contact", :id => false, :force => true do |t|
  end

  create_table "ContactCreditCard", :id => false, :force => true do |t|
  end

  create_table "ContactType", :id => false, :force => true do |t|
  end

  create_table "CountryRegion", :id => false, :force => true do |t|
  end

  create_table "CountryRegionCurrency", :id => false, :force => true do |t|
  end

  create_table "CreditCard", :id => false, :force => true do |t|
  end

  create_table "Culture", :id => false, :force => true do |t|
  end

  create_table "Currency", :id => false, :force => true do |t|
  end

  create_table "CurrencyRate", :id => false, :force => true do |t|
  end

  create_table "Customer", :id => false, :force => true do |t|
  end

  create_table "CustomerAddress", :id => false, :force => true do |t|
  end

  create_table "DatabaseLog", :id => false, :force => true do |t|
  end

  create_table "Department", :primary_key => "DepartmentID", :force => true do |t|
    t.string   "Name",         :limit => 50, :null => false
    t.string   "GroupName",    :limit => 50, :null => false
    t.datetime "ModifiedDate",               :null => false
  end

  add_index "Department", ["Name"], :name => "AK_Department_Name", :unique => true

  create_table "Document", :id => false, :force => true do |t|
  end

  create_table "Employee", :primary_key => "EmployeeID", :force => true do |t|
    t.string   "NationalIDNumber", :limit => 15,                    :null => false
    t.integer  "ContactID",                                         :null => false
    t.string   "LoginID",          :limit => 256,                   :null => false
    t.integer  "ManagerID"
    t.string   "Title",            :limit => 50,                    :null => false
    t.datetime "BirthDate",                                         :null => false
    t.string   "MaritalStatus",    :limit => 1,                     :null => false
    t.string   "Gender",           :limit => 1,                     :null => false
    t.datetime "HireDate",                                          :null => false
    t.boolean  "SalariedFlag",                    :default => true, :null => false
    t.integer  "VacationHours",    :limit => 2,   :default => 0,    :null => false
    t.integer  "SickLeaveHours",   :limit => 2,   :default => 0,    :null => false
    t.boolean  "CurrentFlag",                     :default => true, :null => false
    t.string   "rowguid",          :limit => nil,                   :null => false
    t.datetime "ModifiedDate",                                      :null => false
  end

  add_index "Employee", ["LoginID"], :name => "AK_Employee_LoginID", :unique => true
  add_index "Employee", ["ManagerID"], :name => "IX_Employee_ManagerID"
  add_index "Employee", ["NationalIDNumber"], :name => "AK_Employee_NationalIDNumber", :unique => true
  add_index "Employee", ["rowguid"], :name => "AK_Employee_rowguid", :unique => true

  create_table "EmployeeAddress", :primary_key => "EmployeeID", :force => true do |t|
    t.integer  "AddressID",                   :null => false
    t.string   "rowguid",      :limit => nil, :null => false
    t.datetime "ModifiedDate",                :null => false
  end

  add_index "EmployeeAddress", ["rowguid"], :name => "AK_EmployeeAddress_rowguid", :unique => true

  create_table "EmployeeDepartmentHistory", :primary_key => "EmployeeID", :force => true do |t|
    t.integer  "DepartmentID", :limit => 2, :null => false
    t.integer  "ShiftID",      :limit => 1, :null => false
    t.datetime "StartDate",                 :null => false
    t.datetime "EndDate"
    t.datetime "ModifiedDate",              :null => false
  end

  add_index "EmployeeDepartmentHistory", ["DepartmentID"], :name => "IX_EmployeeDepartmentHistory_DepartmentID"
  add_index "EmployeeDepartmentHistory", ["ShiftID"], :name => "IX_EmployeeDepartmentHistory_ShiftID"

  create_table "EmployeePayHistory", :primary_key => "EmployeeID", :force => true do |t|
    t.datetime "RateChangeDate",              :null => false
    t.decimal  "Rate",                        :null => false
    t.integer  "PayFrequency",   :limit => 1, :null => false
    t.datetime "ModifiedDate",                :null => false
  end

  create_table "ErrorLog", :id => false, :force => true do |t|
  end

  create_table "Illustration", :id => false, :force => true do |t|
  end

  create_table "Individual", :id => false, :force => true do |t|
  end

# Could not dump table "JobCandidate" because of following StandardError
#   Unknown type 'xml' for column 'Resume'

  create_table "Location", :id => false, :force => true do |t|
  end

  create_table "Product", :id => false, :force => true do |t|
  end

  create_table "ProductCategory", :id => false, :force => true do |t|
  end

  create_table "ProductCostHistory", :id => false, :force => true do |t|
  end

  create_table "ProductDescription", :id => false, :force => true do |t|
  end

  create_table "ProductDocument", :id => false, :force => true do |t|
  end

  create_table "ProductInventory", :id => false, :force => true do |t|
  end

  create_table "ProductListPriceHistory", :id => false, :force => true do |t|
  end

  create_table "ProductModel", :id => false, :force => true do |t|
  end

  create_table "ProductModelIllustration", :id => false, :force => true do |t|
  end

  create_table "ProductModelProductDescriptionCulture", :id => false, :force => true do |t|
  end

  create_table "ProductPhoto", :id => false, :force => true do |t|
  end

  create_table "ProductProductPhoto", :id => false, :force => true do |t|
  end

  create_table "ProductReview", :id => false, :force => true do |t|
  end

  create_table "ProductSubcategory", :id => false, :force => true do |t|
  end

  create_table "ProductVendor", :id => false, :force => true do |t|
  end

  create_table "PurchaseOrderDetail", :id => false, :force => true do |t|
  end

  create_table "PurchaseOrderHeader", :id => false, :force => true do |t|
  end

  create_table "SalesOrderDetail", :id => false, :force => true do |t|
  end

  create_table "SalesOrderHeader", :id => false, :force => true do |t|
  end

  create_table "SalesOrderHeaderSalesReason", :id => false, :force => true do |t|
  end

  create_table "SalesPerson", :id => false, :force => true do |t|
  end

  create_table "SalesPersonQuotaHistory", :id => false, :force => true do |t|
  end

  create_table "SalesReason", :id => false, :force => true do |t|
  end

  create_table "SalesTaxRate", :id => false, :force => true do |t|
  end

  create_table "SalesTerritory", :id => false, :force => true do |t|
  end

  create_table "SalesTerritoryHistory", :id => false, :force => true do |t|
  end

  create_table "ScrapReason", :id => false, :force => true do |t|
  end

  create_table "Shift", :primary_key => "ShiftID", :force => true do |t|
    t.string   "Name",         :limit => 50, :null => false
    t.datetime "StartTime",                  :null => false
    t.datetime "EndTime",                    :null => false
    t.datetime "ModifiedDate",               :null => false
  end

  add_index "Shift", ["Name"], :name => "AK_Shift_Name", :unique => true
  add_index "Shift", ["StartTime", "EndTime"], :name => "AK_Shift_StartTime_EndTime", :unique => true

  create_table "ShipMethod", :id => false, :force => true do |t|
  end

  create_table "ShoppingCartItem", :id => false, :force => true do |t|
  end

  create_table "SpecialOffer", :id => false, :force => true do |t|
  end

  create_table "SpecialOfferProduct", :id => false, :force => true do |t|
  end

  create_table "StateProvince", :id => false, :force => true do |t|
  end

  create_table "Store", :id => false, :force => true do |t|
  end

  create_table "StoreContact", :id => false, :force => true do |t|
  end

  create_table "TransactionHistory", :id => false, :force => true do |t|
  end

  create_table "TransactionHistoryArchive", :id => false, :force => true do |t|
  end

  create_table "UnitMeasure", :id => false, :force => true do |t|
  end

  create_table "Vendor", :id => false, :force => true do |t|
  end

  create_table "VendorAddress", :id => false, :force => true do |t|
  end

  create_table "VendorContact", :id => false, :force => true do |t|
  end

  create_table "WorkOrder", :id => false, :force => true do |t|
  end

  create_table "WorkOrderRouting", :id => false, :force => true do |t|
  end

end
