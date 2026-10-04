-- TechStore —  m4_consultas_negocio.
-- Autor: Tamburri Lucas Ivan
-- Fecha: 26-09-2026

SELECT * FROM ventas;       -- esperado: 10 filas

--Consulta 1 — Resumen ejecutivo mensual.
--Total Facturado.
SELECT
EXTRACT(MONTH FROM fecha_venta) AS Mes,
SUM (cantidad * precio_unitario) AS Total_facturado,
COUNT (*) AS Cantidad_pedidos,
AVG(cantidad * precio_unitario) AS Promedio_facturado
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta)
ORDER BY mes;

--Consulta 2 — Ranking de productos.
SELECT Id_producto,
SUM (cantidad * precio_unitario) AS Total_facturado,
SUM (cantidad) AS unidades_vendidas
FROM ventas
GROUP BY Id_producto
ORDER BY Total_facturado DESC
LIMIT 5;

--Consulta 3 — Clientes recurrentes. 
SELECT Id_cliente,
COUNT (*) AS pedidos_x_cliente,
SUM(cantidad * precio_unitario) AS Total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*)>1;

--Consulta 4 — Meses por encima/por debajo del promedio.
SELECT
EXTRACT(MONTH FROM fecha_venta) AS mes,
SUM (cantidad * precio_unitario) AS total_Facturado,
CASE
	WHEN SUM(cantidad * precio_unitario) >= (Select AVG(cantidad * precio_unitario)from ventas)
		THEN 'POR ENCIMA'
			ELSE 'POR DEBAJO'
		END AS comparacion_promedio
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta)
ORDER BY mes;

SELECT 
	    EXTRACT(MONTH FROM fecha_venta) AS mes,
	    SUM(cantidad * precio_unitario) AS total_facturado,
	    CASE 
	        WHEN SUM(cantidad * precio_unitario) >= (
	            SELECT AVG(total_mes) 
	            FROM (
	                SELECT SUM(cantidad * precio_unitario) AS total_mes 
	                FROM ventas 
	                GROUP BY EXTRACT(MONTH FROM fecha_venta)
	            ) AS sub
	        ) THEN 'Por encima'
	        ELSE 'Por debajo'
	    END AS estado_promedio
	FROM ventas
	GROUP BY EXTRACT(MONTH FROM fecha_venta)
	ORDER BY mes;
	--Bloque de cierre. 
	-- Solo 5 de los 10 clientes realizaron mas de un pedido.
	-- Mas del 50% de las ventas estan concentradas en el cliente 1 y 5.
	-- Las ventas mas importantes son generadas por los productos 1 y 3.