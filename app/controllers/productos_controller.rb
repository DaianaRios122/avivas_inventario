class ProductosController < ApplicationController
  before_action :authenticate_usuario!
  load_and_authorize_resource
  before_action :set_producto, only: %i[ show edit update destroy edit_stock ]

  # GET /productos or /productos.json
  def index
    @productos = Producto.where(fecha_baja: nil)  # Filtrar productos que no tienen fecha de baja
  end

  # GET /productos/1 or /productos/1.json
  def show
  end

  # GET /productos/new
  def new
    @producto = Producto.new
  end

  # GET /productos/1/edit
  def edit

  end

  # POST /productos or /productos.json
  def create
    @producto = Producto.new(producto_params)
    if @producto.save
      redirect_to @producto, notice: 'Producto creado exitosamente.'
    else
      flash[:alert] = 'Error al crear el producto.'
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /productos/1 or /productos/1.json
  def update
    # Verifica si el campo de imagenes está vacío y no lo toca si ya hay imágenes existentes
    if params[:producto][:imagenes].blank? && @producto.imagenes.attached?
      # Mantén las imágenes actuales
      params[:producto].delete(:imagenes)
    end
  
    if @producto.update(producto_params)
      redirect_to @producto, notice: 'Producto actualizado exitosamente.'
    else
      flash[:alert] = 'Error al actualizar el producto.'
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /productos/1 or /productos/1.json
  def destroy
    @producto.eliminar_producto
    redirect_to productos_url, notice: 'Producto eliminado (lógicamente) exitosamente.'
  end

  def edit_stock
    # Vista para editar solo el stock disponible
  end

  def change_stock
    if @producto.update(stock_disponible: params[:stock_disponible])
      redirect_to @producto, notice: 'Stock actualizado exitosamente.'
    else
      flash[:alert] = 'Error al actualizar el stock.'
      render :edit_stock, status: :unprocessable_entity
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_producto
    @producto = Producto.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def producto_params
    # Si no se suben nuevas imágenes, no las actualiza
    params[:producto].delete(:imagenes) if params[:producto][:imagenes].blank?
    
    params.require(:producto).permit(:nombre, :descripcion, :precio_unitario, :stock_disponible, :talle, :color, :categoria_id, :fecha_ingreso, imagenes: [])
  end

end
