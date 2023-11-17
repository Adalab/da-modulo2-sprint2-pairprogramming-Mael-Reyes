USE northwind; 

#1. Extraed los pedidos con el máximo "order_date" para cada empleado.
#Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado cada empleado. 
#Para eso nos pide que lo hagamos con una query correlacionada.

SELECT e.employee_id, e.first_name, e.last_name, o.order_date, o.customer_id
	FROM employees AS e
INNER JOIN orders AS o 
	ON e.employee_id=o.employee_id
		WHERE o.order_date =(
			SELECT MAX(order_date)
			FROM orders
				WHERE employee_ID=e.employee_ID);

#2. Extraed el precio unitario máximo (unit_price) de cada producto vendido.
#Supongamos que ahora nuestro jefe quiere un informe de los productos vendidos y su precio unitario. 
#De nuevo lo tendréis que hacer con queries correlacionadas.

SELECT p.product_id AS ProductID,
    (SELECT MAX(o.unit_price)
     FROM order_details AS o
     WHERE o.product_id = p.product_id) AS Max_unit_price
FROM products AS p;

#3. Extraed información de los productos "Beverages"
#En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para identificar un tipo de producto. 
#En concreto, tienen especial interés por los productos con categoría "Beverages". Devuelve el ID del producto, el nombre del producto y su ID de categoría.

SELECT product_id, product_name, category_id 
FROM products
WHERE category_id = 1;

SELECT category_id
FROM categories
WHERE category_name LIKE "Beverages";

SELECT p.product_id, p.product_name, p.category_id
FROM products AS p
INNER JOIN categories AS c 
ON p.category_id= 
(SELECT category_id FROM categories 
WHERE category_name LIKE "Beverages")
GROUP BY p.product_id;

#4. Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país
#Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes, entonces podría dirigirse a estos países para buscar proveedores adicionales.

SELECT country
FROM suppliers
GROUP By country; 

SELECT country 
FROM customers
GROUP by country; 

SELECT c.country
FROM customers AS c
LEFT JOIN suppliers AS s
ON c.country = s.country
WHERE s.country IS NULL
GROUP BY c.country;

SELECT country 
FROM customers 
WHERE country IN (
	SELECT c.country
		FROM customers AS c
	LEFT JOIN suppliers AS s
		ON c.country = s.country
		WHERE s.country IS NULL)
GROUP BY country;


#5. Extraer los clientes que compraron mas de 20 articulos "Grandma's Boysenberry Spread"
#Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos del producto "Grandma's Boysenberry Spread" (ProductID 6) en un solo pedido.

SELECT order_id, product_id, quantity
FROM order_details
WHERE quantity >20; 

SELECT order_id, customer_id
FROM orders; 

SELECT product_id, product_name
FROM products
WHERE product_name LIKE "Grandma's Boysenberry Spread";

SELECT o.order_id
    FROM orders AS o
LEFT JOIN order_details od 
    ON o.order_id = od.order_id
LEFT JOIN products AS p 
    ON od.product_id = p.product_id
    WHERE od.quantity > 20 AND p.product_name LIKE "Grandma's Boysenberry Spread";

SELECT order_id, customer_id
FROM orders
WHERE order_id IN (
    SELECT o.order_id
    FROM orders o
    LEFT JOIN order_details od 
    ON o.order_id = od.order_id
    LEFT JOIN products p 
    ON od.product_id = p.product_id
    WHERE od.quantity > 20 AND p.product_name LIKE "Grandma's Boysenberry Spread");

#6.Extraed los 10 productos más caros
#Nos siguen pidiendo más queries correlacionadas. En este caso queremos saber cuáles son los 10 productos más caros.




 
