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

ActiveRecord::Schema.define(version: 0) do

  create_table "file_lists", primary_key: "Mid", id: :string, limit: 30, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text "file"
  end

  create_table "meetings", primary_key: "Mid", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "MeetingName", limit: 40, null: false
    t.string "MeetingDescption"
    t.string "DoM", limit: 12
    t.string "ToM", limit: 7
    t.string "MeetingCode", limit: 40, null: false
    t.integer "Uid", null: false
    t.index ["MeetingName"], name: "MeetingName", unique: true
    t.index ["Uid"], name: "Uid"
  end

  create_table "user_files", primary_key: "Uid", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "FirstName", limit: 15, null: false
    t.string "SurName", limit: 20, null: false
    t.string "Company", limit: 50, null: false
    t.string "JobTitle", limit: 30, null: false
    t.string "WorkEmail", limit: 100
    t.string "PhoneNum", limit: 11
    t.string "Question1", limit: 50, null: false
    t.string "Question2", limit: 50, null: false
    t.string "Question3", limit: 50, null: false
    t.string "Answer1", limit: 20, null: false
    t.string "Answer2", limit: 20, null: false
    t.string "Answer3", limit: 20, null: false
    t.integer "AvatarID", null: false
  end

  create_table "users", primary_key: "Uid", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "Email", limit: 80, null: false
    t.string "password_digest"
    t.index ["Email"], name: "Email", unique: true
  end

  add_foreign_key "meetings", "users", column: "Uid", primary_key: "Uid", name: "meetings_ibfk_1", on_delete: :cascade
  add_foreign_key "user_files", "users", column: "Uid", primary_key: "Uid", name: "user_files_ibfk_1", on_delete: :cascade
end
