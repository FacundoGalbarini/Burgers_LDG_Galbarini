CREATE DATABASE IF NOT EXISTS Proyecto_Entrega1;
-- Le decimos a MySQL que vamos a trabajar dentro de esta base de datos
USE Proyecto_Entrega1;

-- TABLA 1 — Productos
CREATE TABLE IF NOT EXISTS Productos (
    Producto_ID INT PRIMARY KEY AUTO_INCREMENT,
    SKU VARCHAR(50) NOT NULL,
    Nombre_Producto VARCHAR(150) NOT NULL,
    Categoria VARCHAR(50),
    Precio DECIMAL(10,2)
);

-- TABLA 2 — Sucursales
CREATE TABLE IF NOT EXISTS Sucursales (
    Sucursal_ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Sucursal VARCHAR(100) NOT NULL,
    Ciudad VARCHAR(50),
    Barrio VARCHAR(50),
    Capacidad VARCHAR(50)
);

-- TABLA 3 — Empleados
CREATE TABLE IF NOT EXISTS Empleados (
    Empleado_ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Cargo VARCHAR(50),
    Sucursal_ID INT,
    FOREIGN KEY (Sucursal_ID) REFERENCES Sucursales(Sucursal_ID)
);

-- TABLA 4 — Clientes
CREATE TABLE IF NOT EXISTS Cliente (
    Cliente_ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Genero VARCHAR(10),
    Fecha_Registro DATE
);

-- TABLA 5 — Proveedores
CREATE TABLE IF NOT EXISTS Proveedores (
    Proveedor_ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Proveedor VARCHAR(150),
    Ciudad VARCHAR(50),
    Telefono VARCHAR(30)
);

-- TABLA 6 — Insumos
CREATE TABLE IF NOT EXISTS Dim_Insumo (
    Insumo_ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Insumo VARCHAR(150) NOT NULL,
    Tipo_Insumo VARCHAR(50),
    Unidad_Medida VARCHAR(20),
    Proveedor_ID INT,
    Costo_Unitario DECIMAL(10,2),
    FOREIGN KEY (Proveedor_ID) REFERENCES Proveedores(Proveedor_ID)
);

-- TABLA 8 — Ingredientes por Producto
CREATE TABLE IF NOT EXISTS Ingredientes_Producto (
    Producto_ID INT,
    Ingrediente_ID INT,
    Cantidad_Usada VARCHAR(50),
    PRIMARY KEY (Producto_ID, Ingrediente_ID),
    FOREIGN KEY (Producto_ID) REFERENCES Productos(Producto_ID),
    FOREIGN KEY (Ingrediente_ID) REFERENCES Ingredientes(Ingrediente_ID)
);

-- TABLA 9 — Publicidad
CREATE TABLE IF NOT EXISTS Publicidad (
    Publicidad_ID INT PRIMARY KEY AUTO_INCREMENT,
    Medio VARCHAR(50),
    Costo_Estimado DECIMAL(10,2)
);

-- TABLA 10 — Métodos de pago por sucursal
CREATE TABLE IF NOT EXISTS FormaPagoSucursal (
    FormaPagoSucursal_ID INT PRIMARY KEY AUTO_INCREMENT,
    Sucursal_ID INT,
    Nombre_FormaPago VARCHAR(50),
    FOREIGN KEY (Sucursal_ID) REFERENCES Sucursales(Sucursal_ID)
);

-- TABLA 11 — Promociones
CREATE TABLE IF NOT EXISTS Dim_Promocion (
    Promocion_ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Promo VARCHAR(150),
    Descuento_Porcentaje INT,
    Ventas_Asociadas INT
);

-- TABLA 12 — Turnos
CREATE TABLE IF NOT EXISTS Dim_Turno (
    Turno_ID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Turno VARCHAR(50),
    Hora_Inicio TIME,
    Hora_Fin TIME,
    Porcentaje_Ventas DECIMAL(5,2)
);

-- TABLA 13 — Tipo de Cliente por Sucursal
CREATE TABLE IF NOT EXISTS Dim_TipoCliente (
    TipoCliente_ID INT PRIMARY KEY AUTO_INCREMENT,
    Sucursal_ID INT,
    Descripcion VARCHAR(100),
    Porcentaje_Ventas DECIMAL(5,2),
    FOREIGN KEY (Sucursal_ID) REFERENCES Sucursales(Sucursal_ID)
);

-- TABLA 14 — Ventas por Día de la Semana
CREATE TABLE IF NOT EXISTS Dim_VentasDiaSemana (
    DiaSemana_ID INT PRIMARY KEY AUTO_INCREMENT,
    Sucursal_ID INT,
    Dia_Semana VARCHAR(20),
    Ventas_Promedio DECIMAL(10,2),
    Porcentaje_Sobre_Semana DECIMAL(5,2),
    FOREIGN KEY (Sucursal_ID) REFERENCES Sucursales(Sucursal_ID)
);
-- ---

-- FACT_VENTAS (completa y conectada)
CREATE TABLE IF NOT EXISTS Ventas (
    Venta_ID INT PRIMARY KEY AUTO_INCREMENT,

    -- MÉTRICAS
    Cantidad INT,
    Monto_Total DECIMAL(10,2),
    Costo_Total DECIMAL(10,2),
    Ganancia DECIMAL(10,2),
    Descuento_Aplicado DECIMAL(10,2),

    -- DIMENSIONES
    Producto_ID INT,
    Cliente_ID INT,
    Sucursal_ID INT,
    Empleado_ID INT,
    Promocion_ID INT,
    Turno_ID INT,
    TipoCliente_ID INT,
    DiaSemana_ID INT,
    FormaPagoSucursal_ID INT,
    Publicidad_ID INT,

    FOREIGN KEY (Producto_ID) REFERENCES Productos(Producto_ID),
    FOREIGN KEY (Cliente_ID) REFERENCES Cliente(Cliente_ID),
    FOREIGN KEY (Sucursal_ID) REFERENCES Sucursales(Sucursal_ID),
    FOREIGN KEY (Empleado_ID) REFERENCES Empleados(Empleado_ID),
    FOREIGN KEY (Promocion_ID) REFERENCES Dim_Promocion(Promocion_ID),
    FOREIGN KEY (Turno_ID) REFERENCES Dim_Turno(Turno_ID),
    FOREIGN KEY (TipoCliente_ID) REFERENCES Dim_TipoCliente(TipoCliente_ID),
    FOREIGN KEY (DiaSemana_ID) REFERENCES Dim_VentasDiaSemana(DiaSemana_ID),
    FOREIGN KEY (FormaPagoSucursal_ID) REFERENCES FormaPagoSucursal(FormaPagoSucursal_ID),
    FOREIGN KEY (Publicidad_ID) REFERENCES Publicidad(Publicidad_ID)
);

-- Correciones 

SHOW CREATE TABLE Ingredientes_Producto;

ALTER TABLE Ingredientes_Producto
DROP FOREIGN KEY ingredientes_producto_ibfk_2;
ALTER TABLE Ingredientes_Producto
DROP COLUMN Ingrediente_ID;

ALTER TABLE Ingredientes_Producto
ADD COLUMN Insumo_ID INT;

ALTER TABLE Ingredientes_Productodim_insumo
DROP PRIMARY KEY,
ADD PRIMARY KEY (Producto_ID, Insumo_ID);

ALTER TABLE Ingredientes_Producto
ADD CONSTRAINT fk_ingprod_insumo
FOREIGN KEY (Insumo_ID)
REFERENCES Dim_Insumo(Insumo_ID);

USE Proyecto_Entrega1;
ALTER TABLE Sucursales
MODIFY Capacidad INT;

ALTER TABLE Ingredientes_Producto
DROP COLUMN Cantidad_Usada;

ALTER TABLE Ingredientes_Producto
ADD Cantidad_Usada DECIMAL(10,2),
ADD Unidad_Medida VARCHAR(20);


ALTER TABLE Dim_VentasDiaSemana
DROP COLUMN Ventas_Promedio,
DROP COLUMN Porcentaje_Sobre_Semana
