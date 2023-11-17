#Productos más baratos y caros de nuestra BBDD:
#Desde la división de productos nos piden conocer el precio de 
#los productos que tienen el precio más alto y más bajo. 
#Dales el alias lowestPrice y highestPrice.

USE northwind;
SELECT MIN(unit_price) AS 'lowestPrice', MAX(unit_price) AS 'highestPrice'
FROM products;

#Conociendo el numero de productos y su precio medio:
#Adicionalmente nos piden que diseñemos otra consulta para conocer el número de productos y el precio medio de todos ellos 
#(en general, no por cada producto).

SELECT AVG(unit_price), COUNT(product_id)
FROM products;

#Sacad la máxima y mínima carga de los pedidos de UK:
#Nuestro siguiente encargo consiste en preparar una consulta que devuelva la máxima y mínima cantidad 
#de carga para un pedido (freight) enviado a Reino Unido (United Kingdom).

SELECT MAX(freight), MIN(freight)
FROM orders
WHERE ship_country = "UK" ;

#qué productos en concreto se venden por encima del precio medio para todos los productos de la empresa
SELECT AVG (unit_price)
FROM products;

SELECT * 
FROM products
WHERE unit_price > 28.86
ORDER BY unit_price DESC;

#Qué productos se han descontinuado:
SELECT *
FROM products
WHERE discontinued > 0;

# detalles de aquellos productos no descontinuados, sobre todo el ProductID y ProductName.  
#nos piden que los limitemos a los 10 con ID más elevado

SELECT product_id, product_name
FROM products
WHERE discontinued = 0
ORDER BY product_id DESC 
LIMIT 10;

#Relación entre número de pedidos y máxima carga:
#Desde logística nos piden el número de pedidos y la máxima cantidad de carga de entre los mismos (freight) 
#que han sido enviados por cada empleado (mostrando el ID de empleado en cada caso)

SELECT COUNT(order_id), employee_id, MAX(freight)
FROM orders
GROUP BY employee_id;

# En el resultado anterior se han incluido muchos pedidos cuya fecha de envío estaba vacía, por lo 
#que tenemos que mejorar la consulta en este aspecto. También nos piden que ordenemos los resultados según el ID 
#de empleado para que la visualización sea más sencilla.

SELECT COUNT(order_id), employee_id, MAX(freight)
FROM orders
WHERE shipped_date IS NOT NULL
GROUP BY employee_id
ORDER BY employee_id;

# tendremos que generar una consulta que nos saque el número de pedidos para cada día, 
#mostrando de manera separada el día (DAY()), el mes (MONTH()) y el año (YEAR()).
SELECT 
    DAY(shipped_date) AS dia,
    MONTH(shipped_date) AS mes,
    YEAR(shipped_date) AS año,
    COUNT(*) AS numero_de_pedidos
FROM orders
WHERE shipped_date IS NOT NULL
GROUP BY dia, mes, año
ORDER BY año, mes, dia;

#9.Números de pedidos por día:
#El siguiente paso en el análisis de los pedidos va a consistir en conocer mejor la distribución de los mismos según las fechas. 
#Por lo tanto, tendremos que generar una consulta que nos saque el número de pedidos para cada día, mostrando de manera separada el día (DAY()), el mes (MONTH()) y el año (YEAR()).

SELECT COUNT(order_id) AS cantidad_pedidos, DAY(order_date) AS Día , MONTH(order_date) AS Mes , YEAR(order_date) AS Año
FROM orders
GROUP BY Día, Mes, Año;

#10.Número de pedidos por mes y año:
#La consulta anterior nos muestra el número de pedidos para cada día concreto, pero esto es demasiado detalle. 
#Genera una modificación de la consulta anterior para que agrupe los pedidos por cada mes concreto de cada año.

SELECT COUNT(order_id) AS cantidad_de_pedidos,MONTH (order_date) AS Mes, YEAR (order_date) AS Año 
	FROM orders
	GROUP BY Mes, Año;

#11.Seleccionad las ciudades con 4 o más empleadas:
#Desde recursos humanos nos piden seleccionar los nombres de las ciudades con 4 o más empleadas de cara a estudiar la apertura de nuevas oficinas.

SELECT city, COUNT(city) AS total_empleadas
FROM employees
GROUP BY city
HAVING total_empleadas >= 4;

#12.Cread una nueva columna basándonos en la cantidad monetaria:
#Necesitamos una consulta que clasifique los pedidos en dos categorías ("Alto" y "Bajo") en función de la cantidad monetaria total que han supuesto: por encima o por debajo de 2000 euros.

SELECT order_id, SUM(unit_price*quantity) AS precio_total,
CASE
		WHEN SUM(unit_price*quantity)> 2000 THEN 'Alto'
		ELSE 'Bajo'
	END AS categorias
FROM order_details
GROUP BY order_id;