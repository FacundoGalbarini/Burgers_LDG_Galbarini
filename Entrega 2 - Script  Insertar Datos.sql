USE
Proyecto_Entrega1; 
INSERT INTO Sucursales (Nombre_Sucursal, Ciudad, Barrio, Capacidad) 
VALUES ('Centro', 'Montevideo', 'Centro', '80'), ('Pocitos', 'Montevideo', 'Pocitos', '60'); 

INSERT INTO FormaPagoSucursal (Sucursal_ID, Nombre_FormaPago)
VALUES (1, 'Efectivo'), (1, 'Débito'), (1, 'QR');

INSERT INTO Productos (SKU, Nombre_Producto, Categoria, Precio) 
VALUES ('H001', 'Hamburguesa Clásica', 'Hamburguesas', 300), ('H002', 'Hamburguesa Doble', 'Hamburguesas', 380);
 INSERT INTO Cliente (Nombre, Apellido, Genero, Fecha_Registro)
 VALUES ('Carlos', 'Pérez', 'M', '2024-01-10'), ('Lucía', 'Gómez', 'F', '2024-02-15');
 
 
INSERT INTO Empleados (Nombre, Apellido, Cargo, Sucursal_ID) 
VALUES ('Juan', 'Rodríguez', 'Cocinero', 1), ('Ana', 'López', 'Cajera', 1); 


INSERT INTO Dim_Turno (Nombre_Turno, Hora_Inicio, Hora_Fin, Porcentaje_Ventas)
 VALUES ('Mañana', '08:00', '12:00', 30), ('Noche', '18:00', '23:59', 40); 
 
 
INSERT INTO Dim_TipoCliente (Sucursal_ID, Descripcion, Porcentaje_Ventas) 
VALUES (1, 'Take-away', 60), (1, 'Delivery', 40);

 INSERT INTO Dim_VentasDiaSemana (Sucursal_ID, Dia_Semana, Ventas_Promedio, Porcentaje_Sobre_Semana) 
 
VALUES (1, 'Viernes', 12000, 15.00), (1, 'Sabado', 13000, 16.00), (1, 'Domingo', 14000, 17.00); 
INSERT INTO Publicidad (Medio, Costo_Estimado) VALUES ('Instagram', 5000);

 INSERT INTO Dim_Promocion (Nombre_Promo, Descuento_Porcentaje, Ventas_Asociadas) VALUES ('2x1 Burgers', 50, 0);
 CALL sp_insertar_venta( 1, 1, 1, 1, 1, 2, 1, 1, 1, 1,2, 600, 400, 50);

