USE Proyecto_Entrega1;
CREATE VIEW vw_ventas_por_sucursal AS
SELECT
    s.Nombre_Sucursal,
    SUM(v.Monto_Total) AS Total_Ventas
FROM Ventas v
JOIN Sucursales s ON v.Sucursal_ID = s.Sucursal_ID
GROUP BY s.Nombre_Sucursal;

CREATE VIEW vw_ventas_por_producto AS
SELECT
    p.Nombre_Producto,
    SUM(v.Cantidad) AS Total_Unidades,
    SUM(v.Monto_Total) AS Total_Facturado
FROM Ventas v
JOIN Productos p ON v.Producto_ID = p.Producto_ID
GROUP BY p.Nombre_Producto;
DELIMITER $$

CREATE FUNCTION fn_calcular_ganancia(
    monto DECIMAL(10,2),
    costo DECIMAL(10,2)
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN monto - costo;
END$$

DELIMITER ;

DELIMITER $$

CREATE FUNCTION fn_aplicar_descuento(
    monto DECIMAL(10,2),
    descuento INT
)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    RETURN monto - ((monto * descuento) / 100);
END$$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE sp_insertar_venta (
    IN p_producto INT,
    IN p_cliente INT,
    IN p_sucursal INT,
    IN p_empleado INT,
    IN p_promocion INT,
    IN p_turno INT,
    IN p_tipocliente INT,
    IN p_diasemana INT,
    IN p_formapago INT,
    IN p_publicidad INT,
    IN p_cantidad INT,
    IN p_monto DECIMAL(10,2),
    IN p_costo DECIMAL(10,2),
    IN p_descuento DECIMAL(10,2)
)
BEGIN
    INSERT INTO Ventas (
        Producto_ID, Cliente_ID, Sucursal_ID, Empleado_ID,
        Promocion_ID, Turno_ID, TipoCliente_ID, DiaSemana_ID,
        FormaPagoSucursal_ID, Publicidad_ID,
        Cantidad, Monto_Total, Costo_Total, Ganancia, Descuento_Aplicado
    )
    VALUES (
        p_producto, p_cliente, p_sucursal, p_empleado,
        p_promocion, p_turno, p_tipocliente, p_diasemana,
        p_formapago, p_publicidad,
        p_cantidad,
        p_monto,
        p_costo,
        fn_calcular_ganancia(p_monto, p_costo),
        p_descuento
    );
END$$

DELIMITER ;
DELIMITER $$

CREATE PROCEDURE sp_ventas_totales_sucursal ()
BEGIN
    SELECT * FROM vw_ventas_por_sucursal;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_calcular_ganancia
BEFORE INSERT ON Ventas
FOR EACH ROW
BEGIN
    SET NEW.Ganancia = NEW.Monto_Total - NEW.Costo_Total;
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_actualizar_ventas_promocion
AFTER INSERT ON Ventas
FOR EACH ROW
BEGIN
    IF NEW.Promocion_ID IS NOT NULL THEN
        UPDATE Dim_Promocion
        SET Ventas_Asociadas = Ventas_Asociadas + 1
        WHERE Promocion_ID = NEW.Promocion_ID;
    END IF;
END$$

DELIMITER ;


