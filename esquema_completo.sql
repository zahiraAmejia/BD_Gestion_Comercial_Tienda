-- TABLA 1: CATEGORIAS
CREATE TABLE CATEGORIAS (
    id_categoria INT PRIMARY KEY,
    categoria VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT
);

-- TABLA 2: PROVEEDORES
CREATE TABLE PROVEEDORES (
    id_proveedor INT PRIMARY KEY,
    nombre_provedor VARCHAR(255) NOT NULL,
    contacto VARCHAR(255),
    telefono VARCHAR(20),
    email VARCHAR(255) UNIQUE,
    direccion TEXT
);

-- TABLA 3: METODOS_PAGO
CREATE TABLE METODOS_PAGO (
    id_metodo_pago INT PRIMARY KEY,
    metodo VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT
);

-- TABLA 4: EMPLEADOS
CREATE TABLE EMPLEADOS (
    id_empleado INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    dni VARCHAR(20) UNIQUE,
    cargo VARCHAR(100),
    fecha_ingreso DATE,
    email VARCHAR(255) UNIQUE,
    telefono VARCHAR(20),
    salario NUMERIC(10, 2) NOT NULL
);

-- TABLA 5: CLIENTES
CREATE TABLE CLIENTES (
    id_cliente INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE,
    fecha_registro DATE,
    region VARCHAR(100)
);

-- TABLA 6: PRENDAS 
CREATE TABLE PRENDAS (
    id_prenda INT PRIMARY KEY,
    nombre_prenda VARCHAR(255) NOT NULL,
    categoria VARCHAR(100),
    estado BOOLEAN DEFAULT TRUE,
    stock INT NOT NULL DEFAULT 0,
    precio_unitario NUMERIC(10, 2) NOT NULL,
    etiqueta_genero VARCHAR(50),
    id_proveedor INT, -- FK
    id_categoria INT  -- FK
);

-- TABLA 7: VENTAS 
CREATE TABLE VENTAS (
    id_venta INT PRIMARY KEY,
    fecha DATE NOT NULL,
    cantidad INT NOT NULL,
    estado VARCHAR(50),
    total_ventas NUMERIC(10, 2) NOT NULL,
    id_cliente INT NOT NULL,     -- FK
    id_metodo_pago INT NOT NULL, -- FK
    id_empleado INT NOT NULL     -- FK
);

-- TABLA 8: DETALLE_VENTAS 
CREATE TABLE DETALLE_VENTAS (
    id_detalle INT PRIMARY KEY,
    cantidad INT NOT NULL,
    precio_unitario NUMERIC(10, 2) NOT NULL,
    subtotal NUMERIC(10, 2) NOT NULL,
    id_prenda INT NOT NULL, -- FK
    id_venta INT NOT NULL   -- FK
);


-- 1. Relaciones para PRENDAS
ALTER TABLE PRENDAS
ADD CONSTRAINT fk_prenda_proveedor
    FOREIGN KEY (id_proveedor)
    REFERENCES PROVEEDORES (id_proveedor);

ALTER TABLE PRENDAS
ADD CONSTRAINT fk_prenda_categoria
    FOREIGN KEY (id_categoria)
    REFERENCES CATEGORIAS (id_categoria);


-- 2. Relaciones para VENTAS
ALTER TABLE VENTAS
ADD CONSTRAINT fk_ventas_cliente
    FOREIGN KEY (id_cliente)
    REFERENCES CLIENTES (id_cliente);

ALTER TABLE VENTAS
ADD CONSTRAINT fk_ventas_metodo_pago
    FOREIGN KEY (id_metodo_pago)
    REFERENCES METODOS_PAGO (id_metodo_pago);

ALTER TABLE VENTAS
ADD CONSTRAINT fk_ventas_empleado
    FOREIGN KEY (id_empleado)
    REFERENCES EMPLEADOS (id_empleado);


-- 3. Relaciones para DETALLE_VENTAS
ALTER TABLE DETALLE_VENTAS
ADD CONSTRAINT fk_detalle_prenda
    FOREIGN KEY (id_prenda)
    REFERENCES PRENDAS (id_prenda);

ALTER TABLE DETALLE_VENTAS
ADD CONSTRAINT fk_detalle_venta
    FOREIGN KEY (id_venta)
    REFERENCES VENTAS (id_venta);