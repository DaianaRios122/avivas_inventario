class StorefrontController < ApplicationController
  

  # GET /storefront
  def index
      # Obtener productos activos y filtrar por búsqueda o categoría si se especifican
    @productos = Producto.activos
                         .filter_by_category(params[:categoria_id])
                         .search(params[:query])
                         .page(params[:page]).per(10) # Paginación con kaminari (10 por página)

    @categorias = Categoria.all # Para la navegación por categorías
  end

  # GET /storefront/:id
  def show
    @producto = Producto.activos.find(params[:id])
    @imagenes = @producto.imagenes
  end

end
