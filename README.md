### Avivas Inventario

Este proyecto es una aplicación desarrollada en Ruby on Rails destinada a la gestión de inventarios. A continuación, se describen las decisiones de diseño, los requisitos técnicos, y los pasos para poner en funcionamiento la aplicación.

## :dart: Objetivos del Proyecto

El objetivo principal de este proyecto es desarrollar una aplicación de gestión de inventario de indumentaria para una reconocida cadena de ropa deportiva. La aplicación debe cumplir con los siguientes objetivos específicos:

### Storefront

El Storefront es la cara visible de la cadena de ropa, y deberá permitir a los visitantes ver los productos disponibles, su precio y su stock. No es necesario que los visitantes puedan realizar compras, pero sí que puedan ver la información de los productos. Esta interfaz deberá ser accesible por cualquier visitante, sin necesidad de autenticación.

### Funcionalidades

- Muestra una lista de productos, con sus imágenes, nombre, descripción, precio y stock disponible.
- Permite ver los detalles de un producto específico desde la lista.
- Permite navegar por las distintas categorías de productos.
- Realiza búsquedas por nombre o descripción.

### Requisitos

- Accesible por cualquier visitante sin necesidad de autenticación.

### Administración de Productos

La aplicación permite a los empleados de la cadena gestionar los productos, su stock y su precio. Para ello, se ha implementado una interfaz de administración que permite realizar las siguientes acciones:

### Acciones Disponibles

- **Listar productos**: Presenta una lista de todos los productos existentes.
- **Agregar producto**: Permite la creación de un nuevo producto.
- **Modificar producto**: Permite la modificación de un producto existente.
- **Eliminar producto**: Permite la eliminación de un producto existente. El borrado es lógico, y pone el stock del producto automáticamente en 0.
- **Cambiar stock**: Permite modificar el stock de un producto existente.
- **Mostrar producto en detalle**: Permite visualizar la información completa de un producto específica.


### Navegación y Búsqueda

- **Navegación por categorías**: Los usuarios pueden navegar por las categorías de productos.
- **Búsqueda por nombre y descripción**: Los usuarios pueden buscar productos por su nombre y descripción.
- **Paginado**: La lista de productos incluye paginado para facilitar la navegación.

### Tablas

- **Productos**
- **Categoria**

### Administración de Ventas

La aplicación permite a los empleados de la cadena registrar las ventas realizadas y los productos vendidos. Para ello, se ha implementado una interfaz de administración que permite realizar las siguientes acciones:

- **Listar ventas**: presenta una lista de todas las ventas realizadas.
- **Asentar venta**: permitir la creación de una nueva venta. Cada venta tiene una fecha y hora de realización, y permitir agregar productos vendidos a la misma. Cada producto vendido tiene una cantidad y un precio de venta.
- **Cancelar venta**: permitir la cancelación de una venta realizada. Al cancelarse una, se deberá devolver el stock de los productos vendidos para que queden disponibles nuevamente. Las ventas canceladas no son eliminadas de la base de datos.
- **Mostrar venta en detalle**: Permite visualizar la información completa de una venta específica, incluyendo los productos vendidos, sus cantidades y precios de venta.

### Navegación y Búsqueda

- **Buscar por empleado**: Permite buscar ventas realizadas por un empleado específico.
- **Filtrar por estado**: Permite filtrar ventas activas o canceladas.
- **Paginado**: La lista de ventas incluye paginado para facilitar la navegación.

### Tablas

- **Venta**: Contiene la información general de cada venta.
- **Venta_Producto**: Registra los productos vendidos en cada venta, con su cantidad y precio de venta.

### Gestión de Usuarios

En la aplicación, he implementado un sistema de gestión de usuarios que permite la creación de usuarios con diferentes roles desde la interfaz de administración. Solo los usuarios autenticados pueden acceder a las interfaces de administración, mientras que el Storefront sigue siendo accesible para cualquier visitante, autenticado o no.

Cada usuario tiene los siguientes atributos mínimos:
- Nombre de usuario (único)
- Correo electrónico (único)
- Teléfono
- Contraseña
- Rol
- Fecha de ingreso a la cadena
- Activo

Los usuarios pueden ser desactivados únicamente por un administrador. La desactivación es un borrado lógico, y una vez desactivado, la contraseña del usuario se cambia automáticamente a un valor desconocido, impidiendo su acceso al sistema.

### Roles de Usuario

He definido los siguientes roles de usuario:
- **Administrador**: Acceso completo a todas las funcionalidades de la aplicación.
- **Gerente**: Puede administrar productos y ventas, y gestionar usuarios, excepto crear o modificar usuarios con rol de administrador.
- **Empleado**: Puede administrar productos y ventas, pero no gestionar usuarios.

Todos los roles pueden modificar los datos de su propia cuenta, excepto su rol.

## :wrench: Tecnologías Utilizadas

- **Framework**: Ruby on Rails 8.0.0.
- **Lenguaje**: Ruby 3.3.5.
- **Base de Datos**: SQLite.
- **Autenticación**: Devise.
- **Autorización**: Cancancan.
- **Paginación**: Kaminari.
- **Gestión de Imágenes**: ActiveStorage.

### Decisiones de Diseño

#### Framework Ruby on Rails

Se utilizó la versión estable más reciente del framework Ruby on Rails (8.0.0) por su robustez, facilidad de desarrollo y soporte activo de la comunidad.

#### Lenguaje de Programación

Se usó Ruby 3.3.5, compatible con la versión de Rails seleccionada, garantizando estabilidad y soporte de funcionalidades modernas del lenguaje.

#### Base de Datos

Se optó por SQLite para la persistencia de datos debido a su simplicidad en la configuración y facilidad de uso en entornos de desarrollo.

#### Autenticación

Se implementó la gema Devise para la gestión de usuarios y autenticación, aprovechando su flexibilidad y seguridad.

#### Autorización

Se utilizó la gema Cancancan para gestionar los permisos de acceso de manera declarativa, simplificando el control de acceso en la aplicación.

#### Paginación

La gema Kaminari fue utilizada para implementar la paginación en vistas con conjuntos grandes de datos, mejorando la experiencia del usuario.

### Conjunto de Datos de Prueba

Se incluyó un archivo `db/seeds.rb` que contiene datos de prueba para evaluar el funcionamiento de la aplicación.

### Requisitos Técnicos

Antes de iniciar, asegúrate de tener los siguientes requisitos instalados en tu sistema:

- **Ruby**: Versión 3.3.5.
- **Rails**: Versión 8.0.0.
- **Bundler**: Gem para gestionar dependencias de Ruby.
- **SQLite**: Para el almacenamiento de datos.
- **Git**: Para clonar el repositorio.

### Configuración y Ejecución

Sigue los pasos a continuación para clonar y poner en marcha la aplicación:

1. **Clonar el Repositorio**

    ```sh
    git clone https://github.com/DaianaRios122/avivas_inventario.git
    cd avivas_inventario
    ```

2. **Instalar Dependencias**

    Asegúrate de tener Bundler instalado y ejecuta:

    ```sh
    bundle install
    ```

3. **Configurar la Base de Datos**

    Configura y migra la base de datos:

    ```sh
    rails db:create
    rails db:migrate
    rails db:seed
    ```

4. **Iniciar el Servidor**

    Inicia el servidor de Rails:

    ```sh
    rails server
    ```

    Accede a la aplicación en [http://localhost:3000](http://localhost:3000).

### Acceso a la Aplicación

    Cuando inicies el servidor de Rails con `rails server`, podrás acceder a la aplicación en [http://localhost:3000](http://localhost:3000). La ruta raíz (`root`) muestra el Storefront, la parte pública que no necesita autenticación.

    Para ingresar a la parte administrativa, dirígete a [http://127.0.0.1:3000/usuarios/sign_in](http://127.0.0.1:3000/usuarios/sign_in) e inicia sesión con las siguientes credenciales:

- **Usuario**: admin1@example.com
- **Contraseña**: 123456

    Este usuario tiene el rol de administrador y permisos completos para todas las funcionalidades de la aplicación.

✍️ **Autor**
- Daiana Jennifer Rios Chaure