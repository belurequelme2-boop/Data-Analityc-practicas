
USE Ventas_Tech_DB;

-- Consulta 1: vista base del proyecto

SELECT 
	ventas.fecha_venta,
	clientes.id_cliente,
	clientes.nombre,
	clientes.ciudad,
	productos.nombre_producto,
	categorias.nombre_categoria,
	ventas.cantidad,
	ventas.precio_unitario,
	ventas.cantidad*ventas.precio_unitario AS total_venta
FROM ventas
INNER JOIN clientes
	ON ventas.id_cliente = clientes.id_cliente
INNER JOIN productos
	ON ventas.id_producto = productos.id_producto
INNER JOIN categorias
	ON productos.id_categoria = categorias.id_categoria;

-- Hallazgo: Durante marzo de 2024 se registraron 10 ventas.

-- Consulta 2: clientes sin ventas

SELECT
	clientes.nombre,
	clientes.email,
	clientes.fecha_registro
FROM clientes
LEFT JOIN ventas
	ON clientes.id_cliente = ventas.id_cliente
WHERE ventas.id_cliente IS NULL;

-- Hallazgo: No se identificaron clientes sin compras. 
-- El 100% de los clientes registrados realizo al menos una compra.
-- El area de CRM no dispone de una cartera de clientes inactivos para reactivar.

-- Consulta 3: Productos sin ventas

SELECT
	productos.nombre_producto,
	categorias.nombre_categoria,
	productos.precio
FROM productos
LEFT JOIN ventas
	ON productos.id_producto = ventas.id_producto
INNER JOIN categorias
	ON productos.id_categoria = categorias.id_categoria
WHERE ventas.id_producto IS NULL;

-- Hallazgo: No se identificaron productos sin ventas.
-- El stock registra movimiento comercial.
-- El area de Producto no tiene articulos sin rotacion que requieran revision o campañas.

--- Consulta 4: Consolidado por canal

SELECT	
	canal,
	SUM(total) AS total_canal
FROM
(
	SELECT
		fecha_venta,
		cantidad*precio_unitario AS total,
		'Online' AS canal
	FROM ventas
	WHERE id_producto IN (1,2,3)

	UNION ALL

	SELECT
		fecha_venta,
		cantidad*precio_unitario AS total,
		'Presencial' AS canal
	FROM ventas
	WHERE id_producto IN (4,5,6)

) AS consolidado
GROUP BY canal;

-- Hallazo: el canal online genera la mayor parte de la facturación,
-- con 5314 frente a 1130 del canal presencial.