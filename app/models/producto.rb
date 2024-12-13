class Producto < ApplicationRecord
  belongs_to :categoria 
  
  has_many_attached :imagenes

  validates :nombre, :descripcion, :precio_unitario, :stock_disponible, :categoria_id, presence: true
  validates :categoria_id, presence: { message: "Debe seleccionar una categoría" }
  validates :precio_unitario, numericality: { greater_than_or_equal_to: 0 }
  validates :stock_disponible, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :correct_image_type, on: :create
  validate :correct_image_size, on: :create
  #validates :imagenes, presence: { message: "Debe tener al menos una imagen" }, on: :create
  validates :imagenes, presence: { message: "Debe tener al menos una imagen" }, on: :create, if: :imagenes_present?
  validates :talle, length: { maximum: 50 }, allow_blank: true
  validates :color, length: { maximum: 50 }, allow_blank: true
  validates :fecha_ingreso, presence: true
  validate :fecha_ingreso_valida
  scope :activos, -> { where(fecha_baja: nil) } # Productos activos (no eliminados)
  scope :filter_by_category, ->(categoria_id) { where(categoria_id: categoria_id) if categoria_id.present? }
  scope :search, ->(query) {
     where("LOWER(nombre) LIKE :query OR LOWER(descripcion) LIKE :query", query: "%#{query.downcase}%") if query.present?
  }

  def self.aplicar_filtros(params)
        productos = Producto.activos  # Filtrar productos que no tienen fecha de baja
                            .filter_by_category(params[:categoria_id])
                            .search(params[:query])
                            .page(params[:page]).per(9) # Paginación                     
  end

  # Borrado lógico (poner stock en 0)
  def eliminar_producto
    update(stock_disponible: 0, fecha_baja: Time.current)
  end

  def disminuir_stock(cantidad)
    raise "Stock insuficiente para #{nombre}" if stock_disponible < cantidad

    update!(stock_disponible: stock_disponible - cantidad)
  end

  def incrementar_stock(cantidad)
    update!(stock_disponible: stock_disponible + cantidad)
  end

  private

  # Validación del tipo de imagen
  def correct_image_type
    if imagenes.attached? && !imagenes.all? { |img| img.content_type.in?(%('image/png image/jpg image/jpeg')) }
      errors.add(:imagenes, 'must be a PNG, JPG, or JPEG')
    end
  end

  # Validación del tamaño de la imagen
  def correct_image_size
    if imagenes.attached? && imagenes.any? { |img| img.byte_size > 5.megabytes }
      errors.add(:imagenes, 'each image size must be less than 5MB')
    end
  end

  def fecha_ingreso_valida
    errors.add(:fecha_ingreso, "debe ser una fecha válida") unless fecha_ingreso.is_a?(Date) || fecha_ingreso.is_a?(Time)
  end

  def imagenes_present?
    imagenes.attached?
  end
end
