USE northwind;
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