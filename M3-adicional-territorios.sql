-- TechStore — Script de Inventario
-- Autor: [Tamburri Lucas Ivan]
-- Fecha: [20-09-2026]

-- SECCIÓN DDL ──────────────────────────
-- DROP TABLE
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS categorias;
DROP TABLE IF EXISTS territorios;

-- CREATE TABLE
CREATE TABLE categorias (
id_categoria SERIAL PRIMARY KEY,
nombre_categoria VARCHAR(50)NOT NULL,
descripcion VARCHAR(200)
);
SELECT * FROM categorias;

CREATE TABLE territorios (
id_territorio SERIAL PRIMARY KEY,
ciudad VARCHAR(100) NOT NULL,
provincia VARCHAR (100) NOT NULL,
zona VARCHAR (50)NOT NULL,
pais VARCHAR (50)NOT NULL DEFAULT 'Argentina'
);
SELECT * FROM territorios;

CREATE TABLE productos (
id_producto SERIAL PRIMARY KEY,
nombre_producto VARCHAR(100) NOT NULL,
id_categoria INT NOT NULL,
precio DECIMAL (10,2) NOT NULL,
stock INT NOT NULL DEFAULT '0',
activo BOOLEAN NOT NULL DEFAULT TRUE,
CONSTRAINT fk_productos_categorias
FOREIGN KEY (id_categoria)REFERENCES categorias (id_categoria)
);

SELECT * FROM productos;

CREATE TABLE clientes (
id_cliente SERIAL PRIMARY KEY,
nombre VARCHAR (100) NOT NULL,
email VARCHAR (150) UNIQUE,
id_territorio INT NOT NULL,
fecha_registro DATE NOT NULL, 
CONSTRAINT fk_clientes_territorios 
FOREIGN KEY (id_territorio) REFERENCES territorios(id_territorio)
);

CREATE TABLE ventas (
id_venta SERIAL PRIMARY KEY,
id_cliente INT NOT NULL,
id_producto INT NOT NULL,
cantidad INT NOT NULL,
precio_unitario DECIMAL(10,2) NOT NULL,
fecha_venta DATE NOT NULL,
CONSTRAINT fk_ventas_clientes
FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
CONSTRAINT fk_ventas_productos
FOREIGN KEY (id_producto) REFERENCES productos (id_producto));

SELECT * FROM ventas;

-- SECCIÓN DML ─────────────────────────
-- INSERT INTO
INSERT INTO categorias(nombre_categoria,descripcion)
VALUES ('Computación', 'Laptops, PCs y monitores');
INSERT INTO categorias(nombre_categoria,descripcion)
VALUES ('Accesorios','Periféricos y complementos'),
('Audio','Auriculares y parlantes'),
('Almacenamiento', 'Discos y memorias');

INSERT INTO territorios (ciudad, provincia,zona)
VALUES ('Córdoba', 'Córdoba', 'Centro'),
('Rosario', 'Santa Fe', 'Centro'),
('Mendoza', 'Mendoza', 'Cuyo'),
('Tucuman', 'Tucumán', 'NOA'),
('Buenos Aires', 'Buenos Aires', 'PBA');

INSERT INTO clientes (nombre,email,Id_territorio,fecha_registro)
VALUES ('María López','maria@mail.com',5, '2024-01-05'),
('Carlos Ruiz','carlos@mail.com',1 ,'2024-01-10'),
('Ana Gómez','ana@mail.com',2,'2024-02-01'),
('Pedro Sanz','pedro@mail.com',3,'2024-02-15'),
('Laura Torres','laura@mail.com', 4,'2024-03-01');

INSERT INTO productos(nombre_producto,id_categoria,precio,stock,activo) 
VALUES ('Laptop Pro 15',1, 1200.00, 15,'TRUE'),
('Mouse Inalámbrico',2,28.00, 80, 'TRUE'),
('Monitor 4K 27"',1,450.00, 12, 'TRUE'),
('Auriculares BT Pro',3,120.00, 35, 'TRUE'),
('SSD Externo 1TB',4,130.00, 18, 'TRUE'),
('Teclado Mecánico',2,95.00, 40, 'TRUE');

INSERT INTO ventas (id_cliente,id_producto,cantidad,precio_unitario,fecha_venta)
VALUES (1, 1, 2, 1200.00, '2024-03-05'),
(2, 2, 5,   28.00, '2024-03-06'),
(3, 3, 1,  450.00, '2024-03-07'),
(1, 4, 2,  120.00, '2024-03-08'),
(4, 5, 3,  130.00, '2024-03-10'),
(2, 6, 4,   95.00, '2024-03-11'),
(5, 1, 1, 1200.00, '2024-03-12'),
(3, 2, 8,   28.00, '2024-03-13'),
(4, 4, 1,  120.00, '2024-03-14'),
(5, 3, 2,  450.00, '2024-03-15');

SELECT * FROM categorias;
SELECT * FROM clientes;
SELECT * FROM territorios;
SELECT * FROM productos;
SELECT * FROM ventas;
