/*
SQLyog Community v12.2.5 (64 bit)
MySQL - 5.5.24-log : Database - udem_inventario
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`udem_inventario` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `udem_inventario`;

/*Table structure for table `entradas` */

DROP TABLE IF EXISTS `entradas`;

CREATE TABLE `entradas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feentrada` datetime DEFAULT NULL,
  `persona_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_entradas_clientes_idx` (`persona_id`),
  CONSTRAINT `fk_entradas_clientes` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `entradas` */

insert  into `entradas`(`id`,`feentrada`,`persona_id`) values 
(5,'2016-08-25 10:57:37',3),
(6,'2016-08-26 10:57:50',3),
(7,'2016-08-27 11:00:05',3);

/*Table structure for table `entradas_productos` */

DROP TABLE IF EXISTS `entradas_productos`;

CREATE TABLE `entradas_productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nmcantidad` int(11) DEFAULT NULL,
  `entrada_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `psvalor_unitario` decimal(10,2) DEFAULT '0.00',
  `nmcantidad_disponible` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_entradas_productos_entradas1_idx` (`entrada_id`),
  KEY `fk_entradas_productos_productos1_idx` (`producto_id`),
  CONSTRAINT `fk_entradas_productos_entradas1` FOREIGN KEY (`entrada_id`) REFERENCES `entradas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_entradas_productos_productos1` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `entradas_productos` */

insert  into `entradas_productos`(`id`,`nmcantidad`,`entrada_id`,`producto_id`,`psvalor_unitario`,`nmcantidad_disponible`) values 
(7,20,5,3,'50000.00',20),
(8,20,5,4,'30000.00',20),
(10,20,5,5,'1000.00',20),
(11,10,6,3,'55000.00',10),
(12,10,6,4,'25000.00',10),
(13,10,6,5,'1000.00',10),
(14,20,7,3,'50000.00',20),
(15,20,7,4,'30000.00',20),
(16,30,7,6,'60000.00',30);

/*Table structure for table `personas` */

DROP TABLE IF EXISTS `personas`;

CREATE TABLE `personas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `personas` */

insert  into `personas`(`id`,`name`,`direccion`) values 
(3,'Hugo',NULL),
(4,'Paco',NULL),
(5,'Luis',NULL);

/*Table structure for table `productos` */

DROP TABLE IF EXISTS `productos`;

CREATE TABLE `productos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `nmcantidad` int(11) DEFAULT '0',
  `pssuma_total_valores` decimal(10,2) DEFAULT '0.00',
  `nmsuma_total_productos` int(11) DEFAULT '0',
  `psventa` decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `productos` */

insert  into `productos`(`id`,`name`,`nmcantidad`,`pssuma_total_valores`,`nmsuma_total_productos`,`psventa`) values 
(3,'Vino',50,'2550000.00',50,'66000.00'),
(4,'Queso',50,'1200000.00',50,'36000.00'),
(5,'Aceituna',30,'30000.00',30,'1200.00'),
(6,'Jamon',30,'1800000.00',30,'72000.00');

/*Table structure for table `productos_salidas` */

DROP TABLE IF EXISTS `productos_salidas`;

CREATE TABLE `productos_salidas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nmcantidad` int(11) DEFAULT '0',
  `salida_id` int(11) NOT NULL,
  `producto_id` int(11) NOT NULL,
  `psvalor_venta` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_productos_salidas_salidas1_idx` (`salida_id`),
  KEY `fk_productos_salidas_productos1_idx` (`producto_id`),
  CONSTRAINT `fk_productos_salidas_productos1` FOREIGN KEY (`producto_id`) REFERENCES `productos` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_productos_salidas_salidas1` FOREIGN KEY (`salida_id`) REFERENCES `salidas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `productos_salidas` */

/*Table structure for table `salidas` */

DROP TABLE IF EXISTS `salidas`;

CREATE TABLE `salidas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fesalida` datetime DEFAULT NULL,
  `persona_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_salidas_clientes1_idx` (`persona_id`),
  CONSTRAINT `fk_salidas_clientes1` FOREIGN KEY (`persona_id`) REFERENCES `personas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Data for the table `salidas` */

/* Trigger structure for table `entradas_productos` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `entradas_productos_bi` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `entradas_productos_bi` BEFORE INSERT ON `entradas_productos` FOR EACH ROW BEGIN
	/*Muevo la cantidad a la disponible*/
	set new.nmcantidad_disponible = new.nmcantidad;
	/*Actualizo la tabla de productos con cantidades y valores
	calculados para el costo promedio*/
	update productos
	  set nmcantidad = nmcantidad + new.nmcantidad,
	      nmsuma_total_productos = nmsuma_total_productos + new.nmcantidad,
	      pssuma_total_valores = pssuma_total_valores + 
			( new.nmcantidad * new.psvalor_unitario ),
	      psventa = if(psventa < 	new.psvalor_unitario * 1.2,
			new.psvalor_unitario * 1.2,
			psventa)
	  where id = new.producto_id;
	  
    END */$$


DELIMITER ;

/* Trigger structure for table `productos_salidas` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `productos_salidas_bi` */$$

/*!50003 CREATE */ /*!50017 DEFINER = 'root'@'localhost' */ /*!50003 TRIGGER `productos_salidas_bi` BEFORE INSERT ON `productos_salidas` FOR EACH ROW BEGIN
	/*--- var trabajo ---*/
	 declare no_more_rows boolean default false;
	 /*Control productos*/
	 declare v_nmcantidad int;
	 declare v_psventa dec(10,2);
	 /*Control fifo*/
	 declare v_entrada_producto_id int;
	 declare v_feentrada datetime;
	 declare v_nmcantidad_disponible int;
	 DECLARE v_pendiente INT;
	/*--- cursores ---*/
	 declare cursor1 cursor for
           select entradas_productos.id, nmcantidad_disponible, feentrada
		from entradas_productos, entradas
		where entradas.id = entradas_productos.entrada_id and
			producto_id = new.producto_id and
			nmcantidad_disponible > 0
		order by 3 asc;
	/*--- control ---*/
	declare continue handler for not found 
            set no_more_rows := true;
	/*-------- 1-Validar Inventario ---------*/
	SELECT nmcantidad, psventa
		into v_nmcantidad,v_psventa
		FROM productos
		WHERE id = new.producto_id;
	
	if new.nmcantidad > v_nmcantidad then
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'No hay cantidad suficiente en el inventario';
	end if;
        IF new.psvalor_venta < v_psventa THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Valor venta inferior al permitido';
	END IF;
	/*-------- 2-Restar de Inventario ---------*/
	update productos
		set nmcantidad = nmcantidad - new.nmcantidad
		where id = new.producto_id;
	
	/*-------- 3-FIFO ---------*/
        open cursor1;
	set v_pendiente = new.nmcantidad; /*Todo esta pendiente*/
        LOOP1: loop
            fetch cursor1 into v_entrada_producto_id,v_nmcantidad_disponible,v_feentrada;
            if no_more_rows then
                close cursor1;
                leave LOOP1;
            end if;
        if v_pendiente > v_nmcantidad_disponible then
		/*Queda pendientes*/
		set v_pendiente = v_pendiente - v_nmcantidad_disponible;
		update entradas_productos
			set nmcantidad_disponible = 0
			where id = v_entrada_producto_id;
        else
		UPDATE entradas_productos
			SET nmcantidad_disponible = nmcantidad_disponible - v_pendiente
			WHERE id = v_entrada_producto_id;
		
		CLOSE cursor1;
                LEAVE LOOP1;	
        end if;        
        end loop LOOP1;	 
    END */$$


DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
