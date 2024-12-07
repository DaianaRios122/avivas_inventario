
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

puts "Se han creado #{Categoria.count} categorías de ropa deportiva."
