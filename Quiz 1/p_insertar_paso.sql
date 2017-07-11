DELIMITER $$

USE `udem_bd2_peajes`$$

DROP PROCEDURE IF EXISTS `p_insertar_paso`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p_insertar_paso`(IN v_peaje_id INT, IN v_rfid VARCHAR(15))
BEGIN
		/*Variables de trabajo*/
		DECLARE v_propietario_id INT;
		DECLARE v_pspagos DEC(10,2);
		
		/*Variables punto 1*/
		DECLARE v_categoria_especial INT;
		DECLARE v_a_pagar DEC(10,2);
		
		/*Variables punto 2*/
		DECLARE v_saldo_pro DEC(10,2);
		
		/*Variables punto 3*/
		DECLARE v_id_pers INT;
		
		/*Consultar el valor generico de pafo y codigo del vehiculo*/
		SELECT	categoria.psvalor_por_defecto, propietario.id
		INTO	v_pspagos ,v_propietario_id
		FROM 	propietarios propietario,	
			vehiculos vehiculo,
			categorias categoria
		WHERE	propietario.vehiculo_id = vehiculo.id AND
			categoria.id = vehiculo.categoria_id AND
			propietario.rfid = v_rfid;
			
		/*Punto 1 - Aquí usted debe intentar buscar si el peaje tiene un valor especial*/
		
		SET v_categoria_especial = (SELECT categorias_peajes.categorias_id 
							FROM peajes, categorias_peajes
							WHERE peajes.id = categorias_peajes.peajes_id 
							AND categorias_peajes.categorias_id = (SELECT v.categoria_id FROM vehiculos v, propietarios p WHERE p.vehiculo_id = v.id AND rfid = v_rfid));
		IF v_categoria_especial IS NULL THEN
			SET v_a_pagar = v_pspagos;
		ELSE
			SET v_a_pagar = (SELECT psvalor	
						FROM categorias_peajes 
						WHERE peajes_id = v_peaje_id 
						AND categorias_id = v_categoria_especial);					
		END IF;	
		
		/*Punto 2 - Aquí usted debe intentar Validar si hay suficiente dinero para cubrir el paso del peaje*/
		
		SET v_saldo_pro = (SELECT per.pssaldo 
					FROM personas per, propietarios pro
					WHERE pro.persona_id = per.id
					AND rfid = v_rfid);
					
		/*Si no tiene suficiente dinero */
		IF (v_saldo_pro < v_a_pagar ) THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'El propietario no tiene dinero suficiente';	
		ELSE 				
			/* Si hay suficiente dinero Se inserta en paso del peaje*/
			INSERT INTO pasos
				( peaje_id,	propietario_id,	pspago )
				VALUES
				( v_peaje_id,	v_propietario_id,	v_pspagos);
			/*Punto 3 - Aquí usted debe debitar del saldo de la persona el valor del peaje*/
			SET v_id_pers = (SELECT p.id 
						FROM personas p, propietarios pro
						WHERE p.id = pro.persona_id
						AND pro.id = v_propietario_id);
			UPDATE personas 
			  SET pssaldo = v_saldo_pro - v_a_pagar
			  WHERE id = v_id_pers;
			
			
		END IF;
		
    	END$$

DELIMITER ;