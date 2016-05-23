# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160503050245) do

  create_table "carbrands", force: :cascade do |t|
    t.string   "brandname",    limit: 255
    t.integer  "brand_option", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "carmodels", force: :cascade do |t|
    t.string   "modelname",  limit: 255
    t.integer  "brand_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "cars", force: :cascade do |t|
    t.string   "carsname",     limit: 255
    t.string   "carsname_lao", limit: 255
    t.string   "city",         limit: 255
    t.string   "distinct",     limit: 255
    t.integer  "user_id",      limit: 4
    t.string   "address",      limit: 255
    t.string   "address_lao",  limit: 255
    t.string   "cellphone",    limit: 255
    t.string   "latitude",     limit: 255
    t.string   "longitude",    limit: 255
    t.string   "delyn",        limit: 255
    t.string   "detail_lao",   limit: 255
    t.string   "detail_eng",   limit: 255
    t.string   "brand",        limit: 255
    t.string   "model",        limit: 255
    t.string   "newold",       limit: 255
    t.integer  "price",        limit: 4
    t.string   "price_unit",   limit: 255
    t.string   "year",         limit: 255
    t.string   "odometer",     limit: 255
    t.string   "transmission", limit: 255
    t.string   "fueltype",     limit: 255
    t.string   "drivetype",    limit: 255
    t.string   "color",        limit: 255
    t.string   "bodytype",     limit: 255
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "image",        limit: 255
  end

  create_table "categories", force: :cascade do |t|
    t.string   "categorylao",  limit: 255
    t.string   "categoryname", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: :cascade do |t|
    t.string   "cityname",   limit: 255
    t.string   "city_lao",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "districts", force: :cascade do |t|
    t.string   "districtname", limit: 255
    t.string   "district_lao", limit: 255
    t.integer  "city_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "data_id",    limit: 4
    t.integer  "gubun",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: :cascade do |t|
    t.integer  "data_id",    limit: 4
    t.string   "img",        limit: 255
    t.integer  "gubun",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "markets", force: :cascade do |t|
    t.string   "marketname",     limit: 255
    t.string   "marketname_lao", limit: 255
    t.integer  "user_id",        limit: 4
    t.string   "category1",      limit: 255
    t.string   "category2",      limit: 255
    t.string   "city",           limit: 255
    t.string   "district",       limit: 255
    t.string   "address",        limit: 255
    t.string   "address_lao",    limit: 255
    t.string   "open1",          limit: 255
    t.string   "close1",         limit: 255
    t.string   "desc1",          limit: 255
    t.string   "open2",          limit: 255
    t.string   "close2",         limit: 255
    t.string   "desc2",          limit: 255
    t.string   "open3",          limit: 255
    t.string   "close3",         limit: 255
    t.string   "desc3",          limit: 255
    t.string   "fax",            limit: 255
    t.string   "cellphone",      limit: 255
    t.string   "tel",            limit: 255
    t.string   "email",          limit: 255
    t.string   "homepage",       limit: 255
    t.string   "latitude",       limit: 255
    t.string   "longitude",      limit: 255
    t.string   "delyn",          limit: 255
    t.string   "detail_lao",     limit: 255
    t.string   "detail_eng",     limit: 255
    t.string   "keyword",        limit: 255
    t.string   "keyword_lao",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image",          limit: 255
    t.string   "tel2",           limit: 255
    t.string   "enable",         limit: 255
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "roomname",     limit: 255
    t.string   "roomname_lao", limit: 255
    t.integer  "user_id",      limit: 4
    t.string   "address",      limit: 255
    t.string   "address_lao",  limit: 255
    t.string   "cellphone",    limit: 255
    t.string   "tel",          limit: 255
    t.string   "email",        limit: 255
    t.string   "latitude",     limit: 255
    t.string   "longitude",    limit: 255
    t.string   "delyn",        limit: 255
    t.string   "detail_lao",   limit: 255
    t.string   "detail_eng",   limit: 255
    t.string   "status",       limit: 255
    t.string   "product",      limit: 255
    t.integer  "price",        limit: 4
    t.string   "price_unit",   limit: 255
    t.string   "land_size",    limit: 255
    t.string   "rooms",        limit: 255
    t.string   "toilets",      limit: 255
    t.string   "built_year",   limit: 255
    t.string   "amenities",    limit: 255
    t.string   "parking",      limit: 255
    t.string   "rent_option",  limit: 255
    t.string   "city",         limit: 255
    t.string   "district",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tests", force: :cascade do |t|
    t.integer  "num",        limit: 4
    t.string   "name",       limit: 255
    t.string   "city",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255
    t.string   "password",               limit: 255
    t.string   "name",                   limit: 255
    t.string   "sex",                    limit: 255
    t.string   "tel",                    limit: 255
    t.string   "usertype",               limit: 255
    t.string   "birthdate",              limit: 255
    t.string   "marketname",             limit: 255
    t.string   "cellphone",              limit: 255
    t.string   "marketphone",            limit: 255
    t.string   "marketemail",            limit: 255
    t.string   "address",                limit: 255
    t.string   "access_token",           limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_reset_token",   limit: 255
    t.datetime "password_reset_sent_at"
    t.string   "empno",                  limit: 255
    t.string   "recomno",                limit: 255
  end

end
