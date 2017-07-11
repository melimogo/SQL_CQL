/*
SQLyog Community v12.4.0 (64 bit)
MySQL - 5.7.14 : Database - calidadaire
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`calidadaire` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `calidadaire`;

/*Table structure for table `indice_calidad` */

DROP TABLE IF EXISTS `indice_calidad`;

CREATE TABLE `indice_calidad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) NOT NULL,
  `color` varchar(45) NOT NULL,
  `Zonas_id` int(11) NOT NULL,
  PRIMARY KEY (`id`,`Zonas_id`),
  KEY `fk_Indice_calidad_Zonas1_idx` (`Zonas_id`),
  CONSTRAINT `fk_Indice_calidad_Zonas1` FOREIGN KEY (`Zonas_id`) REFERENCES `zonas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `indice_calidad` */

/*Table structure for table `reportes` */

DROP TABLE IF EXISTS `reportes`;

CREATE TABLE `reportes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `valor` float NOT NULL,
  `Sensores_id` int(11) NOT NULL,
  `Zonas_id` int(11) NOT NULL,
  PRIMARY KEY (`id`,`Sensores_id`,`Zonas_id`),
  KEY `fk_Reportes_Sensores1_idx` (`Sensores_id`),
  KEY `fk_Reportes_Zonas1_idx` (`Zonas_id`),
  CONSTRAINT `fk_Reportes_Sensores1` FOREIGN KEY (`Sensores_id`) REFERENCES `sensores` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Reportes_Zonas1` FOREIGN KEY (`Zonas_id`) REFERENCES `zonas` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `reportes` */

/*Table structure for table `sensores` */

DROP TABLE IF EXISTS `sensores`;

CREATE TABLE `sensores` (
  `id` int(11) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  `unidadMed` varchar(45) NOT NULL,
  `valorMin` float NOT NULL,
  `valorMax` float NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `sensores` */

insert  into `sensores`(`id`,`nombre`,`descripcion`,`unidadMed`,`valorMin`,`valorMax`) values 
(1,'precipitacion','medir cantidad precipitaciones ','mm/h',10,30),
(2,'humedad','medir cantidad de vapor de agua','%',15,80),
(3,'direccion del viento','medir las corriente de viento','km/h',5,20),
(4,'presion atmosferica','medir la presion en el sitio','MB',0,2);

/*Table structure for table `zonas` */

DROP TABLE IF EXISTS `zonas`;

CREATE TABLE `zonas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `latitud` decimal(10,8) NOT NULL,
  `longitud` decimal(10,8) NOT NULL,
  `nombre` varchar(45) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `zonas` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
