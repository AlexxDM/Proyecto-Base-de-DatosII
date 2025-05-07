CREATE DATABASE Pasteleria;
USE Pasteleria;

-- Tabla de usuarios (administradores y operadores)
CREATE TABLE usuarios(
    id_usuario INT AUTO_INCREMENT,
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL, -- Almacenará hash de contraseña
    nombre_completo VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ultimo_acceso TIMESTAMP NULL,
    PRIMARY KEY (id_usuario))
    ENGINE = InnoDB;

-- Tabla de clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT ,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    email VARCHAR(100),
    direccion VARCHAR(200),
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(id_cliente))
    ENGINE = InnoDB;

-- Tabla de categorías de productos
CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT ,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(200),
    PRIMARY KEY(id_categoria))
    ENGINE = InnoDB;

-- Tabla de productos
CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT ,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(200),
    precio DECIMAL(10,2) NOT NULL,
    id_categoria INT,
    tiempo_preparacion INT, -- Tiempo en horas
    PRIMARY KEY(id_producto),
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria))
    ENGINE = InnoDB;

-- Tabla de pedidos
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT ,
    id_cliente INT NOT NULL,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_entrega DATETIME NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    notas VARCHAR(255),
    id_usuario INT NOT NULL, -- Usuario que registró el pedido
    PRIMARY KEY(id_pedido),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario))
    ENGINE = InnoDB;

-- Tabla de detalles de pedido (permite varios productos por pedido)
CREATE TABLE detalle_pedido (
    id_detalle INT AUTO_INCREMENT ,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    PRIMARY KEY(id_detalle),
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto))
    ENGINE = InnoDB;

-- Tabla para registro de backups
CREATE TABLE bitacora_backups (
    id_backup INT AUTO_INCREMENT ,
    fecha_backup TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    nombre_archivo VARCHAR(255) NOT NULL,
    ruta_archivo VARCHAR(255) NOT NULL,
    id_usuario INT,
    PRIMARY KEY(id_backup),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario))
    ENGINE = InnoDB;

-- Inserción de datos de prueba
-- Categorías
INSERT INTO categorias (nombre, descripcion) VALUES 
('Pasteles', 'Pasteles para toda ocasión'),
('Galletas', 'Galletas artesanales'),
('Cupcakes', 'Cupcakes personalizados'),
('Postres', 'Postres tradicionales');

-- Productos
INSERT INTO productos (nombre, descripcion, precio, id_categoria, tiempo_preparacion) VALUES 
('Pastel de Chocolate', 'Delicioso pastel de chocolate con ganache', 350.00, 1, 24),
('Pastel de Vainilla', 'Esponjoso pastel de vainilla con buttercream', 300.00, 1, 24),
('Pastel de Fresas', 'Pastel de vainilla con fresas naturales', 400.00, 1, 24),
('Galletas de Chispas', 'Galletas con chispas de chocolate', 120.00, 2, 6),
('Cupcakes de Chocolate', 'Cupcakes de chocolate decorados', 180.00, 3, 8),
('Cheesecake', 'Cheesecake tradicional', 380.00, 4, 48);

-- Usuarios (contraseña: admin123 y operador123 - esto solo es representativo, en producción usaríamos los hashes reales)
INSERT INTO usuarios (nombre_usuario, password, nombre_completo, email) VALUES 
('admin', 'ef92b778bafe771e89245b89ecbc08a44a4e166c06659911881f383d4473e94f', 'Administrador Sistema', 'admin@pasteleria.com'),
('operador', '75a58e20bd4cabed5f21cb2ab5d34d5a7da5d5d5d4649d32fce5b67682e6e262', 'Operador Sistema', 'operador@pasteleria.com');

-- Clientes de prueba
INSERT INTO clientes (nombre, apellido, telefono, email, direccion) VALUES 
('Juan', 'Pérez', '5551234567', 'juan@email.com', 'Calle 123, Ciudad'),
('María', 'González', '5552345678', 'maria@email.com', 'Avenida 456, Ciudad'),
('Carlos', 'Rodríguez', '5553456789', 'carlos@email.com', 'Boulevard 789, Ciudad');

-- Pedidos de prueba
INSERT INTO pedidos (id_cliente, fecha_entrega, total, notas, id_usuario) VALUES 
(1, DATE_ADD(NOW(), INTERVAL 2 DAY), 350.00, 'Con dedicatoria "Feliz Cumpleaños"', 2),
(2, DATE_ADD(NOW(), INTERVAL 3 DAY), 600.00, 'Entrega en domicilio', 2),
(3, DATE_ADD(NOW(), INTERVAL 1 DAY), 120.00, 'Recoger en tienda', 2);

-- Detalles de pedidos
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, precio_unitario, subtotal) VALUES 
(1, 1, 1, 350.00, 350.00),
(2, 2, 2, 300.00, 600.00),
(3, 4, 1, 120.00, 120.00);

