
/* De la ciudad donde mas gente vive, quien gana menos? */

SELECT e.nombre
FROM  empleados e
WHERE e.ciudade_id_vive IN (SELECT ciudade_id_vive 
				FROM empleados
				GROUP BY ciudade_id_vive
				HAVING COUNT(*) = (SELECT MAX(contador)
						FROM (SELECT COUNT(*) AS contador, ciudade_id_vive AS ciudad_vive
								FROM empleados
								GROUP BY ciudade_id_vive) empleados))

AND salario IN (SELECT MIN(salario) 
			FROM empleados
			WHERE ciudade_id_vive = e.ciudade_id_vive);
