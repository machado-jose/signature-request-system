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

ActiveRecord::Schema.define(version: 20201106223844) do

  create_table "signatories", force: :cascade do |t|
    t.integer "solicitation_id", null: false
    t.string "name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["solicitation_id"], name: "index_signatories_on_solicitation_id"
  end

  create_table "signatures", force: :cascade do |t|
    t.integer "solicitation_id", null: false
    t.integer "signatory_id", null: false
    t.boolean "is_signed", default: false
    t.boolean "denied", default: false
    t.text "justification"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "signature_image_file_name"
    t.string "signature_image_content_type"
    t.integer "signature_image_file_size"
    t.datetime "signature_image_updated_at"
    t.index ["signatory_id"], name: "index_signatures_on_signatory_id"
    t.index ["solicitation_id"], name: "index_signatures_on_solicitation_id"
  end

  create_table "solicitations", force: :cascade do |t|
    t.string "description", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "document_file_name"
    t.string "document_content_type"
    t.integer "document_file_size"
    t.datetime "document_updated_at"
  end

end
