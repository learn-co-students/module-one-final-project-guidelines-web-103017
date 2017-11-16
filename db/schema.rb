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

ActiveRecord::Schema.define(version: 20171116204741) do

  create_table "beer_ingredients", force: :cascade do |t|
    t.integer "beer_id"
    t.integer "ingredient_id"
  end

  create_table "beers", force: :cascade do |t|
    t.string  "name"
    t.string  "style"
    t.integer "abv"
    t.string  "description"
    t.string  "isorganic"
    t.string  "api_key"
    t.integer "brewery_id"
  end

  create_table "breweries", force: :cascade do |t|
    t.string  "name"
    t.text    "description"
    t.string  "classification"
    t.integer "established"
    t.string  "website"
    t.float   "latitude"
    t.float   "longitude"
    t.string  "address"
    t.string  "city"
    t.string  "state"
    t.string  "country"
    t.integer "postalcode"
    t.string  "api_key"
  end

  create_table "ingredients", force: :cascade do |t|
    t.string  "name"
    t.integer "api_id"
  end

  create_table "user_beers", force: :cascade do |t|
    t.integer "beer_id"
    t.integer "user_id"
    t.integer "rating"
  end

  create_table "users", force: :cascade do |t|
    t.string  "name"
    t.string  "city"
    t.string  "state"
    t.integer "zipcode"
    t.string  "country"
  end

end
