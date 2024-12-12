class Admin::UsuariosController < ApplicationController
  
  before_action :authenticate_usuario!
  load_and_authorize_resource
  #before_action :verify_admin_or_manager
  before_action :verify_admin_or_manager, except: [:edit, :update, :show]  # Excluir las acciones edit/update del check

  
  def index
    @usuarios = Usuario.aplicar_filtros(params)
    puts "Usuarios: #{@usuarios}"
  end

  def new
    @usuario = Usuario.new
  end

  def create
    @usuario = Usuario.new(usuario_params)
    if @usuario.save
      redirect_to admin_usuario_path(@usuario), notice: 'Usuario creado exitosamente.'
    else
      flash[:alert] = 'Error al crear el usuario.'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @usuario = Usuario.find(params[:id])
    # Solo el propio usuario o un administrador/gerente pueden editar
    if current_usuario.empleado? && @usuario.id != current_usuario.id
      redirect_to home_index_path, alert: 'No tienes permisos para editar este usuario.'
    end
  end
  
  
  def update
    @usuario = Usuario.find(params[:id])
    # Verificar si el usuario actual está intentando actualizar su propio rol
    if @usuario.id == current_usuario.id
        # Evitar que un usuario cambie su propio rol
        params[:usuario].delete(:rol) if params[:usuario][:rol].present? && params[:usuario][:rol] != @usuario.rol
    end

    # Verificar si el usuario actual es gerente y si está intentando cambiar el rol a administrador
    if current_usuario.gerente? && params[:usuario][:rol] == 'administrador'
      redirect_to admin_usuarios_path, alert: 'No tienes permisos para asignar el rol de administrador.'
      return
    end
  
    if @usuario.update(usuario_params)
      redirect_to admin_usuario_path(@usuario), notice: 'Usuario actualizado exitosamente.'
    else
      flash[:alert] = 'Error al actualizar el usuario.'
      render :edit, status: :unprocessable_entity
    end
  end


  def show
    @usuario = Usuario.find_by(id: params[:id])
    
    if @usuario.nil?
      flash[:alert] = "Usuario no encontrado."
      redirect_to admin_usuarios_path
    end
  end

  def deactivate
    @usuario = Usuario.find(params[:id])
    if current_usuario.administrador?
      if @usuario.desactivar!
        redirect_to admin_usuarios_path, notice: 'Usuario desactivado exitosamente.'
      else
        redirect_to admin_usuarios_path, alert: 'Error al desactivar el usuario.'
      end
    else
      redirect_to admin_usuarios_path, alert: 'No tienes permisos para desactivar usuarios.'
    end
  end

  private

  def usuario_params
    # Permitir solo ciertos roles según el rol del usuario actual
    if current_usuario.administrador?
      permitted_roles = %i[administrador gerente empleado] # Administrador puede asignar cualquiera de los roles
    elsif current_usuario.gerente?
      permitted_roles = %i[gerente empleado] # Gerente solo puede asignar gerente o empleado
    else
      permitted_roles = [] # Los demás roles no pueden asignar roles
    end
  
    # Obtener el rol actual o un valor predeterminado si no se proporciona
    rol_param = params[:usuario][:rol].presence || @usuario&.rol
  
    # Permitir parámetros adicionales según las validaciones de rol
    params.require(:usuario).permit(:nombre_usuario, :email, :telefono, :activo, :rol, :fecha_ingreso, :password, :password_confirmation)
          .merge(rol: rol_param.to_sym.in?(permitted_roles) ? rol_param : 'empleado')
  end
  
  def verify_admin_or_manager
    logger.debug "Usuario actual: #{current_usuario.rol}"  # Verifica el rol del usuario actual
    puts "Usuario actual: #{current_usuario.rol}"  # Verifica el rol del usuario actual
    unless current_usuario.administrador? || current_usuario.gerente?
      redirect_to home_index_path, alert: 'No tienes permisos para acceder a esta sección.'
    end
  end

end
