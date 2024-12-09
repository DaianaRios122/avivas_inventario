class CreateVenta < ActiveRecord::Migration[8.0]
  def change
    create_table :venta do |t|
      t.datetime :fecha_hora, null: false
      t.decimal :total, precision: 10, scale: 2, null: false
      t.boolean :estado, null: false, default: true
      t.references :usuario, null: false, foreign_key: true
      t.string :cliente

      t.timestamps
    end
  end
end
