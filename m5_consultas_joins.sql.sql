--Consulta 1 — Vista base del proyecto (INNER JOIN)

SELECT
v.fecha_venta,
c.nombre AS nombre_cliente,
p.nombre_producto AS producto,
p.stock AS stock_producto,
p.precio AS precio_producto,
t.ciudad AS lugar_venta,
SUM (v.cantidad * v.precio_unitario) AS total_venta

FROM clientes AS c

JOIN 
	ventas AS v
				ON c.id_cliente = v.id_cliente

JOIN
	productos AS p
				ON v.id_producto = p.id_producto
JOIN
	categorias AS ct
				ON p.id_categoria = ct.id_categoria

JOIN 
	territorios AS t
				ON	c.id_territorio = t.id_territorio

GROUP BY
		v.fecha_venta,
		c.nombre,
		p.nombre_producto,
        p.stock,
        p.precio,
		t.ciudad;

/*Consulta 2 — Clientes sin ventas (LEFT JOIN) Identificá clientes registrados que aún no han realizado ninguna compra. 
Mostrá su nombre, email y fecha de registro. Usá WHERE ... IS NULL para aislar los casos.*/

SELECT
c.nombre AS nombre_cliente,
c.email,
c.fecha_registro AS alta_cliente

FROM clientes AS c

LEFT JOIN 
	ventas AS v
				ON c.id_cliente = v.id_cliente

LEFT JOIN
	productos AS p
				ON v.id_producto = p.id_producto
LEFT JOIN
	categorias AS ct
				ON p.id_categoria = ct.id_categoria

LEFT JOIN 
	territorios AS t
				ON	c.id_territorio = t.id_territorio
WHERE
		v.id_venta IS NULL;

/*Consulta 3 — Productos sin ventas (LEFT JOIN) Identificá productos del catálogo que no tienen ninguna venta registrada.
Mostrá nombre del producto, categoría y precio. Usá WHERE ... IS NULL.*/

SELECT
p.nombre_producto AS producto,
ct.nombre_categoria AS categoria,
p.precio
FROM productos AS p

LEFT JOIN
	ventas AS v
				ON p.id_producto = v.id_producto
LEFT JOIN
	categorias AS ct
				ON p.id_categoria = ct.id_categoria

WHERE	
	 v.id_venta IS NULL;	

SELECT 
    fecha_venta, 
    cantidad, 
    'Online' AS canal
FROM ventas
WHERE fecha_venta < '2024-03-10';

SELECT 
    fecha_venta, 
    cantidad, 
    'Presencial' AS canal
FROM ventas
WHERE fecha_venta >= '2024-03-10';

--Consulta 4 — Consolidado por canal (UNION ALL)
SELECT 
    canal,
    SUM(total) AS total_facturado,
    COUNT(*) AS cantidad_ventas
FROM (
    -- Bloque 1: Ventas Online
    SELECT 
        fecha_venta,
        (cantidad * precio_unitario) AS total,
        'Online' AS canal
    FROM ventas
    WHERE fecha_venta < '2024-03-10'
	
    UNION ALL

    -- Bloque 2: Ventas Presencial
    SELECT 
        fecha_venta,
        (cantidad * precio_unitario) AS total,
        'Presencial' AS canal
    FROM ventas
    WHERE fecha_venta >= '2024-03-10'
) AS consolidado
GROUP BY canal;
