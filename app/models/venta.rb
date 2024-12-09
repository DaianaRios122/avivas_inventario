class Venta < ApplicationRecord
  self.table_name = 'venta'
  belongs_to :usuario
  has_many :venta_productos, dependent: :destroy
  has_many :productos, through: :venta_productos

 
  # Validaciones
  accepts_nested_attributes_for :venta_productos, allow_destroy: true

  validates :fecha_hora, :usuario, :cliente, presence: true
  validates :venta_productos, presence: true
  # Antes de guardar la venta, verifica el stock y calcula el total
  before_save :verificar_stock, :calcular_total


  def cancelar
    raise "La venta ya está cancelada." unless estado

    transaction do
      # Devuelve el stock de cada producto
      venta_productos.each do |vp|
        vp.producto.incrementar_stock(vp.cantidad)
      end

      # Cambiar estado a cancelada
      update!(estado: false)
    end
  end

  private

  def verificar_stock
    venta_productos.each do |vp|
      producto = vp.producto
      if producto.stock_disponible < vp.cantidad
        errors.add(:base, "El producto #{producto.nombre} no tiene suficiente stock.")
        throw :abort
      end
    end
  end

  def calcular_total
    self.total = venta_productos.sum { |vp| vp.cantidad * vp.precio_unitario }
  end

  
end

