class CreateProductos < ActiveRecord::Migration[8.0]
  def change
    create_table :productos do |t|
      t.string :nombre, null: false
      t.text :descripcion, null: false
      t.decimal :precio_unitario, precision: 10, scale: 2, null: false
      t.integer :stock_disponible, null: false, default: 0
      t.datetime :fecha_ingreso,  null: false, default: -> { 'CURRENT_TIMESTAMP' }
      t.datetime :fecha_baja
      t.string :talle
      t.string :color
      t.references :categoria, null: false, foreign_key: true

      t.timestamps
    end
  end
end
