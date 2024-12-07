class CreateCategoria < ActiveRecord::Migration[8.0]
  def change
    create_table :categoria do |t|
      t.string :nombre, null: false

      t.timestamps
    end

     # Agrega un índice único en la columna `nombre`
     add_index :categoria, :nombre, unique: true
  end
end
