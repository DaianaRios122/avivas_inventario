# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(usuario)
   
    return unless usuario # Usuarios no autenticados no tienen permisos

    # Alias personalizado para gestionar usuarios generales
    alias_action :read, :update, :create, :destroy, to: :manage_users

    case usuario.rol
    when 'administrador'
      can :manage, :all # Acceso total para administradores
    when 'gerente'
      can :manage, Producto # Gerentes pueden gestionar productos
      can :manage, Venta
      can :manage_users, Usuario # Aseguramos que los gerentes puedan gestionar usuarios
      # Gerentes pueden gestionar usuarios con rol gerente y empleado
      can [:read, :update, :create], Usuario, rol: ['gerente', 'empleado']
      # Restricciones específicas
      cannot :create, Usuario, rol: 'administrador' # No pueden crear usuarios con rol de administrador
      cannot [:update, :destroy], Usuario, rol: 'administrador' # No pueden actualizar ni eliminar administradores
      cannot :assign_admin_role, Usuario if usuario.gerente? # No pueden asignar el rol de administrador
    when 'empleado'
      can :manage, Producto
      can :manage, Venta
      cannot :manage_users, Usuario # Restringir acceso a usuarios generales explícitamente
      can [:read, :update], Usuario, id: usuario.id # Acceso solo a su propia cuenta
     
    end

    # Todos los roles pueden actualizar sus propios datos
    can [:read, :update], Usuario, id: usuario.id
  
  end
end
