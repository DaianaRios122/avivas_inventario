class VentaProducto < ApplicationRecord
  belongs_to :venta
  belongs_to :producto
  
 
  # Validaciones
  validates :cantidad, numericality: { greater_than: 0 }
  validates :precio_unitario, numericality: { greater_than: 0 }
 
end
