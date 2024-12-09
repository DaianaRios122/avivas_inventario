class VentasController < ApplicationController
  
  before_action :authenticate_usuario!
  load_and_authorize_resource
  before_action :set_venta, only: %i[show destroy]

  # Listar todas las ventas
  def index
    @ventas = Venta.all
  end

  # Crear una nueva venta
  def new
    @venta = Venta.new
    @venta.venta_productos.build # Construye un producto vacío para el formulario
    @productos = Producto.activos
  end

  def create
    @venta = Venta.new(venta_params)
    @venta.usuario = current_usuario # Asigna el usuario actual (ajusta según tu autenticación)
    @productos = Producto.activos

    Venta.transaction do
      if @venta.save
        # Actualizar stock de cada producto vendido
        @venta.venta_productos.each do |vp|
          vp.producto.disminuir_stock(vp.cantidad)
        end
        redirect_to venta_path(@venta), notice: 'Venta registrada exitosamente.'
      else
        render :new, status: :unprocessable_entity
      end
    end
  rescue => e
    flash[:alert] = "Error al registrar la venta: #{e.message}"
    render :new, status: :unprocessable_entity
  end

  def show
      # Esto asegura que `@venta` esté disponible en la vista de show
  end

  # Acción para cancelar una venta
  def destroy
    if @venta.estado # Verifica si la venta está activa
      @venta.cancelar
      redirect_to ventas_path, notice: "La venta fue cancelada exitosamente."
    else
      redirect_to ventas_path, alert: "La venta ya está cancelada."
    end
  rescue => e
    redirect_to ventas_path, alert: "Error al cancelar la venta: #{e.message}"
  end


  private

  def set_venta
    @venta = Venta.find(params[:id])
  end

  def venta_params
    params.require(:venta).permit(:cliente, :fecha_hora, venta_productos_attributes: [:producto_id, :cantidad, :precio_unitario])
  end
end
