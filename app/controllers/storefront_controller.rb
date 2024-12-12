class StorefrontController < ApplicationController
  

  # GET /storefront
  def index
      # Obtener productos activos y filtrar por búsqueda o categoría si se especifican
    @productos =  @productos = Producto.aplicar_filtros(params)

    @categorias = Categoria.all # Para la navegación por categorías
  end

  # GET /storefront/:id
  def show
    @producto = Producto.activos.find(params[:id])
    @imagenes = @producto.imagenes
  end

end
