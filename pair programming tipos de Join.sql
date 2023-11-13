USE northwind; 

#1. Pedidos por empresa en UK:
#Desde las oficinas en UK nos han pedido con urgencia que realicemos una consulta a la base de datos con la que podamos conocer cuántos pedidos ha realizado cada empresa cliente de UK. 
#Nos piden el ID del cliente y el nombre de la empresa y el número de pedidos.

SELECT customer_id AS Identificador,
       ship_name AS NombreEmpresa,
       COUNT(order_id) AS NumeroPedidos
FROM orders
WHERE ship_country = 'UK'
GROUP BY customer_id, ship_name;

#2. Productos pedidos por empresa en UK por año:
#Desde Reino Unido se quedaron muy contentas con nuestra rápida respuesta a su petición anterior y han decidido pedirnos una serie de consultas adicionales. 
#La primera de ellas consiste en una query que nos sirva para conocer cuántos objetos ha pedido cada empresa cliente de UK durante cada año. 
#Nos piden concretamente conocer el nombre de la empresa, el año, y la cantidad de objetos que han pedido. Para ello hará falta hacer 2 joins.

SELECT company_name AS Nombre_Empresa, YEAR(order_date) as Año, SUM(quantity) AS Total
FROM customers
INNER JOIN orders
USING (customer_id)
INNER JOIN order_details
USING(order_id)
GROUP BY Año, Nombre_Empresa;


#3. Mejorad la query anterior:
#Lo siguiente que nos han pedido es la misma consulta anterior pero con la adición de la cantidad de dinero que han pedido por esa cantidad de objetos, teniendo en cuenta los descuentos, etc. 
#Ojo que los descuentos en nuestra tabla nos salen en porcentajes, 15% nos sale como 0.15.

SELECT company_name AS Nombre_Empresa, YEAR(order_date) as Año, quantity AS cantidad ,  unit_price AS precio_unitario, discount AS Descuento
FROM customers
INNER JOIN orders
USING (customer_id)
INNER JOIN order_details
USING(order_id);

SELECT company_name AS Nombre_Empresa, YEAR(order_date) as Año, SUM(quantity) AS cantidad , SUM((unit_price*quantity)*(1-discount)) AS Monto_total
FROM customers
INNER JOIN orders
USING (customer_id)
INNER JOIN order_details
USING(order_id)
GROUP BY Año, Nombre_empresa;

#4. BONUS: Pedidos que han realizado cada compañía y su fecha:
#Desde la central nos han pedido una consulta que indique el nombre de cada compañia cliente junto con cada pedido que han realizado y su fecha.

SELECT order_id AS Pedido, company_name AS Nombre_cliente,  order_date AS Fecha
FROM customers
INNER JOIN orders 
USING (customer_id);

#5. BONUS: Tipos de producto vendidos:
#Ahora nos piden una lista con cada tipo de producto que se han vendido, sus categorías, nombre de la categoría y el nombre del producto, 
#y el total de dinero por el que se ha vendido cada tipo de producto (teniendo en cuenta los descuentos).

SELECT p.product_name AS NompreProducto, c.category_id AS Categoria,c.category_name AS NombreCategoria, SUM((od.unit_price*od.quantity)*(1-od.discount)) AS Monto_total
FROM order_details AS od
INNER JOIN orders AS o
USING (order_id)
INNER JOIN products AS p
USING (product_id)
INNER JOIN categories AS c
USING (category_id)
GROUP BY p.product_name, category_id;

#6.Qué empresas tenemos en la BBDD Northwind:
#Lo primero que queremos hacer es obtener una consulta SQL que nos devuelva el nombre de todas las empresas cliente, los ID de sus pedidos y las fechas.
SELECT order_id AS Pedido, company_name AS Nombre_cliente,  order_date AS Fecha
FROM customers
INNER JOIN orders 
USING (customer_id);

