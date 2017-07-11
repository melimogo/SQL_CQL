/*
SQLyog Community v12.4.0 (64 bit)
MySQL - 5.7.14 : Database - ciaxyz
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ciaxyz` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ciaxyz`;

/*Table structure for table `ciudades` */

DROP TABLE IF EXISTS `ciudades`;

CREATE TABLE `ciudades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `ciudades` */

insert  into `ciudades`(`id`,`nombre`) values 
(1,'Medellin'),
(2,'Envigado'),
(3,'Bogota');

/*Table structure for table `empleados` */

DROP TABLE IF EXISTS `empleados`;

CREATE TABLE `empleados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `direccion` varchar(45) NOT NULL,
  `telefono` varchar(45) NOT NULL,
  `cargo` varchar(45) NOT NULL,
  `salario` decimal(10,2) NOT NULL,
  `empleado_id` int(11) DEFAULT NULL,
  `ciudade_id_nace` int(11) DEFAULT NULL,
  `ciudade_id_vive` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_empleados_empleados1_idx` (`empleado_id`),
  KEY `fk_empleados_ciudades1_idx` (`ciudade_id_nace`),
  KEY `fk_empleados_ciudades2_idx` (`ciudade_id_vive`),
  CONSTRAINT `fk_empleados_ciudades1` FOREIGN KEY (`ciudade_id_nace`) REFERENCES `ciudades` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleados_ciudades2` FOREIGN KEY (`ciudade_id_vive`) REFERENCES `ciudades` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_empleados_empleados1` FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

/*Data for the table `empleados` */

insert  into `empleados`(`id`,`nombre`,`direccion`,`telefono`,`cargo`,`salario`,`empleado_id`,`ciudade_id_nace`,`ciudade_id_vive`) values 
(1,'Nestor','calle siempre viva 123','4449988','Presidente',15000000.00,NULL,1,1),
(2,'Liliana','cara 123','4449987','Jefe Carrera',7000000.00,1,NULL,1),
(3,'Sergio','el retiro','4449986','Prof de Catedra',1200000.00,2,NULL,3),
(40,'Luis Rodrigo','diag','4449985','Jefe Carrera',7000000.00,1,1,1),
(41,'Juan','cara','4449984','Prof de Catedra',800000.00,3,2,2),
(42,'William','cra 1 nro 2','4449983','Prof de Catedra',1800000.00,2,1,1);

/*Table structure for table `estudios` */

DROP TABLE IF EXISTS `estudios`;

CREATE TABLE `estudios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Data for the table `estudios` */

insert  into `estudios`(`id`,`nombre`) values 
(1,'Administracion de Empresas'),
(2,'Ing Sistemas'),
(3,'MBA'),
(4,'Esp Desarrollo Software');

/*Table structure for table `estudios_empleados` */

DROP TABLE IF EXISTS `estudios_empleados`;

CREATE TABLE `estudios_empleados` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `estudio_id` int(11) NOT NULL,
  `empleado_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_estudios_empleados_estudios_idx` (`estudio_id`),
  KEY `fk_estudios_empleados_empleados1_idx` (`empleado_id`),
  CONSTRAINT `fk_estudios_empleados_empleados1` FOREIGN KEY (`empleado_id`) REFERENCES `empleados` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_estudios_empleados_estudios` FOREIGN KEY (`estudio_id`) REFERENCES `estudios` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Data for the table `estudios_empleados` */

insert  into `estudios_empleados`(`id`,`estudio_id`,`empleado_id`) values 
(1,1,1),
(2,3,1),
(3,2,2),
(4,4,2),
(5,2,3);

/*Table structure for table `rangos_salarios` */

DROP TABLE IF EXISTS `rangos_salarios`;

CREATE TABLE `rangos_salarios` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `limite_inferior` decimal(10,2) NOT NULL,
  `limite_superior` decimal(10,2) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `rangos_salarios` */

insert  into `rangos_salarios`(`id`,`limite_inferior`,`limite_superior`,`nombre`) values 
(1,1.00,2000000.00,'A'),
(2,2000001.00,5000000.00,'B'),
(3,5000001.00,99999999.99,'C');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
