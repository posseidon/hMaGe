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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140825175115) do

  create_table "grids", :force => true do |t|
    t.integer "map_id"
    t.string  "grid_id"
    t.spatial "bbox",    :limit => {:srid=>4326, :type=>"polygon"}
  end

  create_table "maps", :force => true do |t|
    t.string   "name",               :default => "Unprocessed Map", :null => false
    t.string   "path",                                              :null => false
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.boolean  "processed",          :default => false
    t.string   "kind"
    t.string   "size"
    t.string   "resolutuon"
    t.string   "publisher"
    t.boolean  "downloadable",       :default => true
    t.integer  "year",               :default => 1900
    t.string   "section",            :default => "0"
    t.string   "theme"
    t.string   "projection",         :default => "EOV"
    t.boolean  "gridding",           :default => false
    t.text     "description"
    t.string   "creator"
    t.string   "participante"
    t.string   "language",           :default => "HU"
    t.text     "remarks"
    t.integer  "physical_size",      :default => 0
    t.string   "source",             :default => "ELTE TeGeTa"
  end

  create_table "names", :force => true do |t|
    t.string  "original"
    t.string  "current"
    t.text    "description"
    t.spatial "latlon",      :limit => {:srid=>4326, :type=>"point"}
  end

  create_table "pg_search_documents", :force => true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "",       :null => false
    t.string   "encrypted_password",     :default => "",       :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.string   "role",                   :default => "viewer"
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
