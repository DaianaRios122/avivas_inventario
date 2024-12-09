
Categoria.destroy_all
# Crear las categorías de ropa deportiva
categorias = [
  'Remeras',
  'Pantalones',
  'Shorts',
  'Zapatillas',
  'Camperas',
  'Buzos',
  'Medias',
  'Gorras',
  'Guantes',
  'Calzas',
  'Botines',
  'Mochilas',
]

categorias.each do |nombre|
    Categoria.create!(nombre: nombre)
end
Usuario.destroy_all

usuarios = [
  { email: 'admin1@example.com', password: '123456', password_confirmation: '123456', nombre_usuario: 'admin1', rol: 0 },
  { email: 'admin2@example.com', password: '123456', password_confirmation: '123456', nombre_usuario: 'admin2', rol: 0 }
]

usuarios.each do |usuario|
  Usuario.create!(usuario)
end


puts "Se han creado #{Usuario.count} usuarios con rol administrador."
puts "Se han creado #{Categoria.count} categorías de ropa deportiva."
