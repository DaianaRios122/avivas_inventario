class AddCamposEspanolToUsuarios < ActiveRecord::Migration[8.0]
  def change
    add_column :usuarios, :nombre_usuario, :string, null: false
    add_column :usuarios, :telefono, :string
    add_column :usuarios, :rol, :integer, null: false, default: 2 # Rol por defecto: empleado
    add_column :usuarios, :fecha_ingreso, :date, default: -> { 'CURRENT_DATE' }
    add_column :usuarios, :activo, :boolean, default: true
    add_index :usuarios, :nombre_usuario, unique: true
  end
end
