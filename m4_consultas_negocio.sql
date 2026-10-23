-- CONSULTA 1: Resumen ejecutivo mensual

SELECT
    MONTH(fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes;

-- CONSULTA 2: Ranking: TOP 5 productos por facturación

SELECT TOP 5
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC;

-- CONSULTA 3: Clientes recurrentes

SELECT
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1
ORDER BY total_gastado DESC;

-- CONSULTA 4: Meses por encima o por debajo del promedio

WITH ventas_mensuales AS (
    SELECT
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
    )
SELECT
    mes,
    total_facturado,
    CASE
        WHEN total_facturado >
            (SELECT AVG(total_facturado) FROM ventas_mensuales)
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM ventas_mensuales;


-- HALLAZGOS DEL ANÁLISIS

-- 1
-- El producto con id_producto = 1 fue el de mayor facturación,
-- generando un total de 3600.00 en ventas.

-- 2
-- Los clientes con id_cliente = 1 y id_cliente = 5 fueron los que más gastaron
-- con 2640.00 y 2100.00 respectivamente.

-- 3
-- En marzo se registraron 10 pedidos por un total facturado de 6444.00
-- y con un ticket promedio de 644.40.