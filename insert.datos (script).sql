-- Le decimos a MySQL que seguimos trabajando en nuestra base de datos
USE ScanntechBI;

-- Insertamos los registros en la tabla Dim_Tiempo
-- Nota: Como el ID no es auto-incremental, debemos especificarlo.
INSERT INTO Dim_Tiempo (Fecha_ID, Fecha_Completa, Anio, Mes, Dia, Nombre_Mes, Trimestre)
VALUES
(20251026, '2025-10-26', 2025, 10, 26, 'Octubre', 4),
(20251027, '2025-10-27', 2025, 10, 27, 'Octubre', 4),
(20251028, '2025-10-28', 2025, 10, 28, 'Octubre', 4);

-- Verificamos que se haya cargado
SELECT * FROM Dim_Tiempo;

-- Insertamos los registros en la tabla Dim_Producto
-- (Producto_ID, SKU, Nombre_Producto, Categoria, Marca, Precio_Unitario_Actual)
INSERT INTO Dim_Producto (SKU, Nombre_Producto, Categoria, Marca, Precio_Unitario_Actual)
VALUES
('77900101', 'Gaseosa Cola 1.5L', 'Bebidas', 'Marca A', 1450.00),
('77900102', 'Gaseosa Naranja 1.5L', 'Bebidas', 'Marca A', 1430.50),
('77900201', 'Papas Fritas Clásicas 100g', 'Snacks', 'Marca B', 820.75),
('77900202', 'Maní Salado 150g', 'Snacks', 'Marca B', 600.00),
('77900301', 'Leche Entera 1L', 'Lácteos', 'Marca C', 950.20),
('77900302', 'Yogur Frutilla 150g', 'Lácteos', 'Marca C', 510.00),
('77900103', 'Agua Mineral Sin Gas 1.5L', 'Bebidas', 'Marca D', 700.00);

-- Verificamos que se haya cargado (¡y vemos los IDs que se crearon!)
SELECT * FROM Dim_Producto;

-- Insertamos los registros en la tabla Dim_Sucursal
-- (Sucursal_ID, Nombre_Sucursal, Cadena, Region, Ciudad)
INSERT INTO Dim_Sucursal (Nombre_Sucursal, Cadena, Region, Ciudad)
VALUES
('Local Centro', 'Super A', 'Montevideo', 'Montevideo'),
('Local Pocitos', 'Super A', 'Montevideo', 'Montevideo'),
('Tienda Copacabana', 'Varejão B', 'Rio de Janeiro', 'Rio de Janeiro'),
('Mercado Paulista', 'Varejão B', 'São Paulo', 'São Paulo');

-- Verificamos los IDs creados
SELECT * FROM Dim_Sucursal;

-- Insertamos las transacciones en la tabla Fact_Ventas
-- (Venta_ID, Cantidad_Vendida, Monto_Vendido, Fecha_ID, Producto_ID, Sucursal_ID)
INSERT INTO Fact_Ventas (Cantidad_Vendida, Monto_Vendido, Fecha_ID, Producto_ID, Sucursal_ID)
VALUES
-- Ventas del día 26/10
(2, 2900.00, 20251026, 1, 1), -- 2 Gaseosas Cola en Suc. 1
(1, 820.75, 20251026, 3, 1), -- 1 Papas Fritas en Suc. 1
(5, 3500.00, 20251026, 7, 2), -- 5 Aguas Minerales en Suc. 2
(1, 950.20, 20251026, 5, 3), -- 1 Leche en Suc. 3 (Brasil)

-- Ventas del día 27/10
(1, 1430.50, 20251027, 2, 1), -- 1 Gaseosa Naranja en Suc. 1
(3, 1800.00, 20251027, 4, 3), -- 3 Maní Salado en Suc. 3
(2, 1020.00, 20251027, 6, 4), -- 2 Yogures en Suc. 4

-- Ventas del día 28/10
(1, 1450.00, 20251028, 1, 2), -- 1 Gaseosa Cola en Suc. 2
(1, 820.75, 20251028, 3, 2), -- 1 Papas Fritas en Suc. 2
(4, 2800.00, 20251028, 7, 4); -- 4 Aguas Minerales en Suc. 4

-- ¡Verificamos nuestra tabla de hechos completa!
SELECT * FROM Fact_Ventas;