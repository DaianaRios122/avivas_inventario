# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_12_07_222548) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "categoria", force: :cascade do |t|
    t.string "nombre", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nombre"], name: "index_categoria_on_nombre", unique: true
  end

  create_table "productos", force: :cascade do |t|
    t.string "nombre", null: false
    t.text "descripcion", null: false
    t.decimal "precio_unitario", precision: 10, scale: 2, null: false
    t.integer "stock_disponible", default: 0, null: false
    t.datetime "fecha_ingreso", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "fecha_baja"
    t.string "talle"
    t.string "color"
    t.integer "categoria_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["categoria_id"], name: "index_productos_on_categoria_id"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "nombre_usuario", null: false
    t.string "telefono"
    t.integer "rol", default: 2, null: false
    t.date "fecha_ingreso", default: -> { "CURRENT_DATE" }
    t.boolean "activo", default: true
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["nombre_usuario"], name: "index_usuarios_on_nombre_usuario", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  end

  create_table "venta", force: :cascade do |t|
    t.datetime "fecha_hora", null: false
    t.decimal "total", precision: 10, scale: 2, null: false
    t.boolean "estado", default: true, null: false
    t.integer "usuario_id", null: false
    t.string "cliente"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["usuario_id"], name: "index_venta_on_usuario_id"
  end

  create_table "venta_productos", force: :cascade do |t|
    t.integer "venta_id", null: false
    t.integer "producto_id", null: false
    t.integer "cantidad", null: false
    t.decimal "precio_unitario", precision: 10, scale: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["producto_id"], name: "index_venta_productos_on_producto_id"
    t.index ["venta_id"], name: "index_venta_productos_on_venta_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "productos", "categoria", column: "categoria_id"
  add_foreign_key "venta", "usuarios"
  add_foreign_key "venta_productos", "productos"
  add_foreign_key "venta_productos", "venta"
end
