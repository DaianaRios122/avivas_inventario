class Usuario < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Roles
  enum :rol, { administrador: 0, gerente: 1, empleado: 2 }

  # Validaciones
  validates :nombre_usuario, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { within: 6..128 }, if: :password_required?

  validate :activo?, on: :sign_in
  validate :validar_fecha_ingreso 
  validates :rol, inclusion: { in: %w[administrador gerente empleado] }
  validate :gerente_no_asigna_admin, if: :gerente?

  # los scopes para los filtros
  scope :by_rol, ->(rol) { where(rol: rol) }
  scope :by_activo, ->(activo) { where(activo: activo) }

  def self.aplicar_filtros(params)
    usuarios = Usuario.all.order(:nombre_usuario)
    usuarios = usuarios.by_rol(params[:rol]) if params[:rol].present?
    usuarios = usuarios.by_activo(params[:activo]) if params[:activo].present?
    usuarios.page(params[:page]).per(4)
  end

  # Desactivar un usuario
  def desactivar!
    if self.update(
      activo: false,
      password: SecureRandom.hex(16),
      password_confirmation: SecureRandom.hex(16)
    )
      true
    else
      Rails.logger.error("Error al desactivar el usuario: #{self.errors.full_messages.join(', ')}")
      false
    end
  end

  private

  def activo?
    errors.add(:base, 'Tu cuenta está desactivada.') unless activo
  end
  # Determina si la contraseña es requerida
  def password_required?
    return false if !activo
    new_record? || password.present? || password_confirmation.present?
  end

  # Valida que la fecha de ingreso sea válida
  def validar_fecha_ingreso
    if fecha_ingreso.present? && !fecha_ingreso.is_a?(Date)
      errors.add(:fecha_ingreso, 'debe ser una fecha válida.')
    end
  end

  def gerente_no_asigna_admin
    if rol == 'administrador'
      errors.add(:rol, 'No tienes permisos para asignar el rol de administrador.')
    end
  end
end
