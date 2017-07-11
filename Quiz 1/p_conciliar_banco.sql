DELIMITER $$

USE `udem_bd2_peajes`$$

DROP PROCEDURE IF EXISTS `p_conciliar_banco`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p_conciliar_banco`()
BEGIN
  	DELIMITER $$

USE `udem_bd2_peajes`$$

DROP PROCEDURE IF EXISTS `p_conciliar_banco`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `p_conciliar_banco`()
BEGIN
		-- Declaracion de variables 
  		DECLARE done INT DEFAULT 0;

  		-- Variables YYYYY,ZZZZ,MMMMM
		DECLARE v_psvalor DECIMAL(10,2);
		DECLARE v_cdrecibo_banco VARCHAR(15);
		DECLARE v_fetransaccion DATETIME;

		-- contador para la cantidad e registro con el recibo igual 
		DECLARE v_id_con INT;

		-- variable id de recaras
		DECLARE v_id_rec INT;

		--Contador para el numero de veces que aparece 
		--el registro en la tabla de recargas
		DECLARE v_cant_pag INT ;


		-- variables de comparacion para los contadores de las tablas 
		-- y la resta de las variables 
		DECLARE v_t_1 INT;
		DECLARE v_t_2 INT;
		

		DECLARE v_c_1 INT;
		
		
		
	DECLARE cursor1 CURSOR FOR 
		SELECT id, psvalor, cdrecibo_banco, fetransaccion
			FROM 	conciliacionesbancarias;
			
	DECLARE CONTINUE HANDLER FOR SQLSTATE '02000' SET done = 1;
	
	OPEN cursor1;
	REPEAT
		FETCH cursor1 INTO v_id_conciliacion, v_psvalor, v_cdrecibo_banco,v_fetransaccion;
		-- Si encontro datos
		IF NOT done THEN
			
		-- saber la cantidad de `pasos``pasos`registros con el mismo
		-- recibo, transaccion y valor
			SELECT COUNT(r.cdrecibo_banco), r.id
			INTO v_t_1, v_t_2
			FROM recargas r
			WHERE r.cdrecibo_banco = v_cdrecibo_banco
			AND r.ferecarga = v_fetransaccion
			AND r.psvalor = v_psvalor
			AND r.snvalidada = 'N';

			SELECT COUNT(c.cdrecibo_banco) 
			INTO v_c_1
			FROM conciliacionesbancarias c
			WHERE r.cdrecibo_banco = v_cdrecibo_banco
			AND r.ferecarga = v_fetransaccion
			AND r.psvalor = v_psvalor;

			-- si es 1 no hay repetidos
			SET v_id_con = v_c_1 - v_t_1;

			-- saber la cantidad de registros con el mismo recibo 
			SELECT COUNT(cdrecibo_banco)
			INTO v_cant_pag
			FROM recargas
			WHERE cdrecibo_banco = v_cdrecibo_banco;

			-- condiciones de casos de error
			-- caso 3
			IF v_cant_pag > 1 THEN
				UPDATE conciliacionesbancarias
					SET cderror = 'Hay multiples '
					WHERE id = v_id_conciliacion;
			END IF;
			--caso 2
			IF v_cant_pag == 0 THEN
					UPDATE conciliacionesbancarias
					SET cderror = 'no encontrado'
					WHERE id = v_id_conciliacion;
			END IF;
			--caso 
			IF v_id_con == 0 AND v_c_1 == 1 AND v_t_1 == 1 THEN
				UPDATE conciliacionesbancarias
				SET cderror = 'Sin Error'
				WHERE id = v_id_conciliacion;
				UPDATE recargas 
					set snvalidada = 'S'
					where id = v_t_2;
 
			END IF;

			IF v_id_con == 1 THEN
				update conciliacionesbancarias
					set cderror = 'Hay multiples '
					where id = v_id_conciliacion;
			END if; 

			
			
			SET done = 0;
		END IF; 
	UNTIL done 
	END REPEAT;
	CLOSE cursor1;
	
    	END$$

DELIMITER ;