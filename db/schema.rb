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

ActiveRecord::Schema.define(version: 20140125155220) do

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "image_base64",    default: "data:image/jpeg;base64,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"
    t.string   "remember_token"
    t.boolean  "admin",           default: false
    t.boolean  "is_active",       default: true
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
