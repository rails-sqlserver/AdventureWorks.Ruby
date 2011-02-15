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

ActiveRecord::Schema.define(:version => 0) do

  create_table "AWBuildVersion", :primary_key => "SystemInformationID", :force => true do |t|
    t.string   "Database Version", :limit => 25, :null => false
    t.datetime "VersionDate",                    :null => false
    t.datetime "ModifiedDate",                   :null => false
  end

  create_table "Address", :primary_key => "AddressID", :force => true do |t|
    t.string   "AddressLine1",    :limit => 60,  :null => false
    t.string   "AddressLine2",    :limit => 60
    t.string   "City",            :limit => 30,  :null => false
    t.integer  "StateProvinceID",                :null => false
    t.string   "PostalCode",      :limit => 15,  :null => false
    t.string   "rowguid",         :limit => nil, :null => false
    t.datetime "ModifiedDate",                   :null => false
  end

