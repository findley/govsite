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

ActiveRecord::Schema.define(:version => 20120118213133) do

  create_table "bills", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "billstatus", :force => true do |t|
    t.integer  "session",                   :default => 0, :null => false
    t.string   "billtype",   :limit => 2,                  :null => false
    t.integer  "number",                    :default => 0, :null => false
    t.text     "title",                                    :null => false
    t.text     "fulltitle",                                :null => false
    t.datetime "statusdate",                               :null => false
    t.text     "statusxml",                                :null => false
    t.text     "status",     :limit => 255
  end

  add_index "billstatus", ["fulltitle"], :name => "fulltitle", :length => {"fulltitle"=>100}
  add_index "billstatus", ["statusdate"], :name => "statusdate"

  create_table "billtitles", :id => false, :force => true do |t|
    t.integer "session",                :default => 0,  :null => false
    t.string  "type",      :limit => 2, :default => "", :null => false
    t.integer "number",                 :default => 0,  :null => false
    t.text    "title",                                  :null => false
    t.string  "titletype", :limit => 0,                 :null => false
  end

  add_index "billtitles", ["session", "type", "number"], :name => "bill"
  add_index "billtitles", ["title"], :name => "title", :length => {"title"=>60}

  create_table "billusc", :id => false, :force => true do |t|
    t.integer "session",               :null => false
    t.string  "type",    :limit => 2,  :null => false
    t.integer "number",                :null => false
    t.string  "ref",     :limit => 30, :null => false
  end

  add_index "billusc", ["ref", "session"], :name => "ref"
  add_index "billusc", ["session", "type", "number"], :name => "bill"

  create_table "committees", :force => true do |t|
    t.string "type",        :limit => 10, :default => "", :null => false
    t.string "parent",      :limit => 10
    t.text   "displayname",                               :null => false
    t.text   "url"
  end

  create_table "people", :force => true do |t|
    t.text    "firstname",   :limit => 255,                 :null => false
    t.text    "middlename",  :limit => 255
    t.text    "nickname",    :limit => 255
    t.text    "lastname",    :limit => 255,                 :null => false
    t.text    "namemod",     :limit => 255
    t.text    "lastnameenc", :limit => 255,                 :null => false
    t.text    "lastnamealt", :limit => 255
    t.date    "birthday"
    t.string  "gender",      :limit => 1,   :default => "", :null => false
    t.text    "religion",    :limit => 255
    t.string  "osid",        :limit => 50
    t.string  "bioguideid",  :limit => 7
    t.integer "pvsid"
    t.string  "fecid",       :limit => 9
    t.text    "metavidid",   :limit => 255
    t.string  "youtubeid",   :limit => 36
    t.text    "twitterid",   :limit => 255
    t.string  "lismemberid", :limit => 6
    t.integer "icpsrid"
    t.integer "fbid",        :limit => 8
  end

  add_index "people", ["bioguideid"], :name => "bioguideid", :unique => true
  add_index "people", ["lastname"], :name => "lastname", :length => {"lastname"=>30}
  add_index "people", ["lastnamealt"], :name => "lastnamealt", :length => {"lastnamealt"=>15}
  add_index "people", ["lastnameenc"], :name => "lastnameenc", :length => {"lastnameenc"=>15}
  add_index "people", ["lismemberid"], :name => "lismemberid"
  add_index "people", ["middlename"], :name => "middlename", :length => {"middlename"=>15}

  create_table "people_committees", :primary_key => "people_committee_id", :force => true do |t|
    t.integer "personid",                  :default => 0,  :null => false
    t.string  "committeeid", :limit => 10, :default => "", :null => false
    t.text    "type",                                      :null => false
    t.text    "name",                                      :null => false
    t.text    "subname"
    t.text    "role"
    t.text    "housecode",                                 :null => false
    t.text    "senatecode",                                :null => false
  end

  add_index "people_committees", ["personid"], :name => "personid"

  create_table "people_roles", :primary_key => "personroleid", :force => true do |t|
    t.integer "personid",                 :default => 0,     :null => false
    t.string  "type",      :limit => 8,   :default => "",    :null => false
    t.date    "startdate"
    t.date    "enddate"
    t.text    "party",     :limit => 255
    t.string  "state",     :limit => 5
    t.integer "district",  :limit => 2,   :default => 0
    t.integer "class",     :limit => 1
    t.string  "url",       :limit => 100
    t.string  "title",     :limit => 0,   :default => "REP", :null => false
    t.text    "address"
  end

  add_index "people_roles", ["personid"], :name => "personid"
  add_index "people_roles", ["state", "enddate"], :name => "state"

  create_table "people_votes", :force => true do |t|
    t.integer  "personid",                 :null => false
    t.string   "voteid",    :limit => 10,  :null => false
    t.datetime "date",                     :null => false
    t.string   "vote",      :limit => 0,   :null => false
    t.text     "displayas", :limit => 255, :null => false
  end

  add_index "people_votes", ["personid", "date"], :name => "bydate"
  add_index "people_votes", ["voteid", "personid"], :name => "SECONDARY"

  create_table "users", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "votes", :force => true do |t|
    t.datetime "date",                     :null => false
    t.integer  "seq",                      :null => false
    t.text     "description",              :null => false
    t.text     "result",                   :null => false
    t.integer  "billsession"
    t.string   "billtype",    :limit => 2
    t.integer  "billnumber"
    t.string   "amdtype",     :limit => 1
    t.integer  "amdnumber"
  end

  add_index "votes", ["billsession", "billtype", "billnumber"], :name => "bill"
  add_index "votes", ["date", "seq"], :name => "date"

end
