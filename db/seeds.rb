VentaProducto.destroy_all
Venta.destroy_all
Producto.destroy_all
Usuario.destroy_all
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

usuarios = [
  { email: 'admin1@example.com', password: '123456', password_confirmation: '123456', nombre_usuario: 'admin1', rol: 0 },
  { email: 'admin2@example.com', password: '123456', password_confirmation: '123456', nombre_usuario: 'admin2', rol: 0 },
  { email: 'gerente@example.com', password: '123456', password_confirmation: '123456', nombre_usuario: 'Gerente', rol: 1 },
  { email: 'empleado@example.com', password: '123456', password_confirmation: '123456', nombre_usuario: 'Empleado', rol: 2 }
]

usuarios.each do |usuario|
  Usuario.create!(usuario)
end



productos = [
  {
    nombre: 'Zapatillas deportivas',
    descripcion: 'Zapatillas cómodas para running.',
    precio_unitario: 120.99,
    stock_disponible: 50,
    talle: '35-42',
    color: 'Negro, Blanco, Azul, Celeste',
    categoria: Categoria.find_by(nombre: 'Zapatillas'),
    imagenes: ['zapatilla1.jpeg', 'Zapatilla2.jpeg', 'Zapatilla3.jpeg', 'Zapatilla4.jpeg','Zapatilla5.jpeg']
  },
  {
    nombre: 'Remera de entrenamiento',
    descripcion: 'Remera de algodón transpirable.',
    precio_unitario: 25.49,
    stock_disponible: 20,
    talle: 'S,M,L,XL',
    color: 'Blanco, Negro, Celeste',
    categoria: Categoria.find_by(nombre: 'Remeras'),
    imagenes: ['RemeraAdidasNegro.jpeg', 'RemeraAdidas.jpeg']
  },
  {
    nombre: 'Zapatillas-Mujer',
    descripcion: 'Estas zapatillas de mujer están diseñadas para ofrecerte el equilibrio perfecto entre comodidad y estilo. Confeccionadas con materiales de alta calidad, son ideales tanto para tus actividades diarias como para momentos de relajación. Su diseño moderno y versátil combina con cualquier look, desde casual hasta más deportivo.',
    precio_unitario: 45.00,
    stock_disponible: 75,
    talle: '35-40',
    color: 'Azul,Negro, Marron ,Blanco',
    categoria: Categoria.find_by(nombre: 'Zapatillas'),
    imagenes: ['ZapatillasMujer.jpeg','ZapatillaMujer2.jpeg', 'ZapatillaMujer3.jpeg']
  },
  {
    nombre: 'Short Deportivo',
    descripcion: ' Facilita el movimiento y proporciona ventilación.',
    precio_unitario: 25.49,
    stock_disponible: 10,
    talle: 'S,M,L,XL',
    color: 'Blanco, Negro',
    categoria: Categoria.find_by(nombre: 'Shorts'),
    imagenes: ['ShortsBlanco1.jpeg', 'ShortsBlanco2.jpeg']

  },
  {
    nombre: 'Mochila',
    descripcion: ' Buena calidad',
    precio_unitario: 55.49,
    stock_disponible: 10,
    talle: '',
    color: 'Blanco, Negro',
    categoria: Categoria.find_by(nombre: 'Mochilas'),
    imagenes: ['Mochila.jpeg', 'Mochila2.jpeg']
  },
  {
    nombre: 'Calza Deportiva-Mujer',
    descripcion: ' Tejido elástico de alta calidad que se adapta perfectamente al cuerpo y permite una total libertad de movimiento.',
    precio_unitario: 20.49,
    stock_disponible: 10,
    talle: 'S,M,L,XL',
    color: 'Blanco, Negro, Rosa',
    categoria: Categoria.find_by(nombre:  'Calzas'),
    imagenes: ['CalsaRosa1.jpeg', 'CalsaRosa2.jpeg', 'CalzaRosa3.jpeg', 'CalzaRosa4.jpeg']
  },
  {
    nombre: 'Campera Deportiva',
    descripcion: ' Mantente seco y protegido en cualquier clima.',
    precio_unitario: 85.49,
    stock_disponible: 40,
    talle: 'S,M,L,XL',
    color: 'Blanco, Negro, Celeste',
    categoria: Categoria.find_by(nombre:  'Camperas'),
    imagenes: ['CamperaCeleste1.jpeg', 'CamperaCeleste2.jpeg']
  },
  {
    nombre: 'Botin Deportivo',
    descripcion: ' Buena Calida y precio.',
    precio_unitario: 95.49,
    stock_disponible: 40,
    talle: '35-43',
    color: 'Blanco, Negro, Celeste',
    categoria: Categoria.find_by(nombre:  'Botines'),
    imagenes: ['Botines.jpeg', 'Botines2.jpeg', 'Botines3.jpeg']
  },
  {
    nombre: 'Gorra Deportiva',
    descripcion: ' Buena Calida y precio.',
    precio_unitario: 15.49,
    stock_disponible: 10,
    talle: '',
    color: 'Blanco, Negro',
    categoria: Categoria.find_by(nombre:  'Gorras'),
    imagenes: ['Gorra.jpeg', 'Gorra1.jpeg']
  },
  {
    nombre: 'Medias',
    descripcion: ' Buena Calida y precio.',
    precio_unitario: 10.49,
    stock_disponible: 100,
    talle: '',
    color: 'Blanco, Negro, Gris',
    categoria: Categoria.find_by(nombre:  'Medias'),
    imagenes: ['Medias.jpeg']
  }

]

productos.each do |producto_data|
  producto = Producto.create!(
    nombre: producto_data[:nombre],
    descripcion: producto_data[:descripcion],
    precio_unitario: producto_data[:precio_unitario],
    stock_disponible: producto_data[:stock_disponible],
    talle: producto_data[:talle],
    color: producto_data[:color],
    categoria: producto_data[:categoria],
    fecha_ingreso: Time.current  # Asigna la fecha de ingreso actual
  )

  producto_data[:imagenes].each do |imagen|
    imagen_path = Rails.root.join('db', 'seeds', 'images', imagen)
    if File.exist?(imagen_path)
      puts "Imagen encontrada: #{imagen_path}" # Esto imprimirá si la imagen es encontrada
      producto.imagenes.attach(io: File.open(imagen_path), filename: imagen)
    else
      puts "Imagen no encontrada: #{imagen_path}" # Esto imprimirá si la imagen NO se encuentra
    end
  end
end



# Crear ventas
ventas = [
  {
    fecha_hora: Time.current,
    cliente: 'Juan Pérez',
    usuario: Usuario.find_by(email: 'admin1@example.com'), 
    estado: true,
    venta_productos_attributes: [
      {
        producto: Producto.find_by(nombre: 'Zapatillas deportivas'),
        cantidad: 2,
        precio_unitario: Producto.find_by(nombre: 'Zapatillas deportivas').precio_unitario
      },
      {
        producto: Producto.find_by(nombre: 'Remera de entrenamiento'),
        cantidad: 1,
        precio_unitario: Producto.find_by(nombre: 'Remera de entrenamiento').precio_unitario
      }
    ]
  },
  {
    fecha_hora: Time.current - 1.day,
    cliente: 'María López',
    usuario: Usuario.find_by(email: 'admin2@example.com'), 
    estado: true,
    venta_productos_attributes: [
      {
        producto: Producto.find_by(nombre: 'Short Deportivo'),
        cantidad: 3,
        precio_unitario: Producto.find_by(nombre: 'Short Deportivo').precio_unitario
      },
      {
        producto: Producto.find_by(nombre: 'Calza Deportiva-Mujer'),
        cantidad: 2,
        precio_unitario: Producto.find_by(nombre: 'Calza Deportiva-Mujer').precio_unitario
      }
    ]
  }
]

ventas.each do |venta_data|
  # Simula el usuario actual, ya que no hay acceso a `current_usuario` en seeds
  usuario_actual = venta_data[:usuario]

  Venta.transaction do
    # Crear la instancia de venta
    venta = Venta.new(
      fecha_hora: venta_data[:fecha_hora],
      cliente: venta_data[:cliente],
      usuario: usuario_actual, # Asignar el usuario simulado
      estado: venta_data[:estado],
      venta_productos_attributes: venta_data[:venta_productos_attributes]
    )

    if venta.save
      # Actualizar stock de cada producto vendido
      venta.venta_productos.each do |vp|
        vp.producto.disminuir_stock(vp.cantidad)
      end
      puts "Venta registrada exitosamente para #{venta.cliente}"
    else
      raise "Error al registrar la venta: #{venta.errors.full_messages.join(', ')}"
    end
  rescue => e
    puts "Error al registrar la venta: #{e.message}"
  end
end

puts "Se han creado #{Venta.count} ventas con productos asociados."
puts "Se han creado #{Producto.count} productos con imágenes adjuntas."
puts "Se han creado #{Usuario.count} usuarios con rol administrador."
puts "Se han creado #{Categoria.count} categorías de ropa deportiva."
