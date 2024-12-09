class CreateVentaProductos < ActiveRecord::Migration[8.0]
  def change
    create_table :venta_productos do |t|
      t.references :venta, null: false, foreign_key: true
      t.references :producto, null: false, foreign_key: true
      t.integer :cantidad, null: false
      t.decimal :precio_unitario, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
