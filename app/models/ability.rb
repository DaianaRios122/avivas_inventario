# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(usuario)
   
    return unless usuario # Usuarios no autenticados no tienen permisos

    case usuario.rol
    when 'administrador'
      can :manage, :all # Acceso total para administradores
    when 'gerente'
      can :manage, Producto # Gerentes pueden gestionar productos
      can :manage, Venta
      can [:read, :update], Usuario, rol: ['gerente', 'empleado'] # Gerentes pueden gestionar usuarios excepto administradores
      cannot [:update, :destroy], Usuario, rol: 'administrador'
      cannot :assign_admin_role, Usuario if usuario.gerente?
    when 'empleado'
      can :manage, Producto
      can :manage, Venta
    end

    # Todos los roles pueden actualizar sus propios datos
    can [:read, :update], Usuario, id: usuario.id
  
  end
end
