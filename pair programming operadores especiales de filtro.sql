USE northwind; 

#Ciudades que empiezan con "A" o "B".
#Por un extraño motivo, nuestro jefe quiere que le devolvamos una tabla con aquellas compañias que están afincadas en ciudades que empiezan por "A" o "B". 
#Necesita que le devolvamos la ciudad, el nombre de la compañia y el nombre de contacto.
SELECT company_name AS Nombre_compañia, contact_name AS contacto, city AS ciudad
FROM customers
WHERE city LIKE "A%" OR city LIKE "B%"; 

#Número de pedidos que han hecho en las ciudades que empiezan con L.
#En este caso, nuestro objetivo es devolver los mismos campos que en la query anterior el número de total de pedidos que han hecho todas las ciudades que empiezan por "L".

SELECT c.company_name AS Nombre_compañia, c.contact_name AS contacto, c.city AS ciudad, COUNT(o.order_id) AS Total_pedidos
FROM orders AS o
INNER JOIN customers AS c ON o.customer_id=c.customer_id
WHERE city LIKE "L%"
GROUP BY Nombre_compañia, contacto, ciudad;

#Todos los clientes cuyo "contact_title" no incluya "Sales".
#Nuestro objetivo es extraer los clientes que no tienen el contacto "Sales" en su "contact_title". Extraer el nombre de contacto, su posisión (contact_title) y el nombre de la compañia.
