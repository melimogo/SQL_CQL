
/*De la ciudad donde mas gente vive, quien gana menos?*/

SELECT c.nombre AS 'Nombre ciudad',COUNT(*)
FROM ciudades c, empleados`entradas` e 
GROUP BY c.nombre
HAVING COUNT(*);