/*
SQLyog Ultimate v12.5.1 (64 bit)
MySQL - 10.4.25-MariaDB : Database - matricula
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`matricula` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;

USE `matricula`;

/*Table structure for table `alumnos_matriculas` */

DROP TABLE IF EXISTS `alumnos_matriculas`;

CREATE TABLE `alumnos_matriculas` (
  `idmatricula` int(11) NOT NULL AUTO_INCREMENT,
  `alumno` varchar(100) NOT NULL,
  `fechanac` date NOT NULL,
  `numdoc` varchar(11) NOT NULL,
  `iddocente` int(11) NOT NULL,
  `idcarrera` int(11) NOT NULL,
  `periodo` varchar(10) NOT NULL,
  `semestre` varchar(10) NOT NULL,
  `fechainicio` date NOT NULL,
  `fechafinal` date DEFAULT NULL,
  `pago` decimal(7,2) DEFAULT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idmatricula`),
  UNIQUE KEY `uk_numdoc_alum` (`numdoc`),
  KEY `fk_docent_docentes` (`iddocente`),
  KEY `fk_idcarre_carre` (`idcarrera`),
  CONSTRAINT `fk_docent_docentes` FOREIGN KEY (`iddocente`) REFERENCES `docentes` (`iddocente`),
  CONSTRAINT `fk_idcarre_carre` FOREIGN KEY (`idcarrera`) REFERENCES `carreras` (`idcarrera`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `alumnos_matriculas` */

insert  into `alumnos_matriculas`(`idmatricula`,`alumno`,`fechanac`,`numdoc`,`iddocente`,`idcarrera`,`periodo`,`semestre`,`fechainicio`,`fechafinal`,`pago`,`estado`,`create_at`,`update_at`) values 
(1,'Marcelo Aquije, Roger','2000-05-12','21548796',1,1,'2023','I','2023-06-12','0000-00-00',537.50,'1','2023-05-23 22:43:17',NULL),
(2,'Garay Ronceros, Ana','2001-06-20','21365487',2,2,'2023','II','2023-07-20','0000-00-00',645.50,'1','2023-05-23 22:43:17',NULL),
(3,'Pachas Meneses, Sergio','2002-09-15','23569874',3,3,'2023','III','2023-08-21','0000-00-00',706.30,'1','2023-05-23 22:43:17',NULL);

/*Table structure for table `carreras` */

DROP TABLE IF EXISTS `carreras`;

CREATE TABLE `carreras` (
  `idcarrera` int(11) NOT NULL AUTO_INCREMENT,
  `idcurso` int(11) DEFAULT NULL,
  `nombrecarrera` varchar(100) NOT NULL,
  `duracion` int(11) NOT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idcarrera`),
  UNIQUE KEY `uk_nomcarre_carreras` (`nombrecarrera`),
  KEY `fk_curso_cursos` (`idcurso`),
  CONSTRAINT `fk_curso_cursos` FOREIGN KEY (`idcurso`) REFERENCES `cursos` (`idcurso`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `carreras` */

insert  into `carreras`(`idcarrera`,`idcurso`,`nombrecarrera`,`duracion`,`estado`,`create_at`,`update_at`) values 
(1,1,'Ingenieria de Software',3,'1','2023-05-23 22:42:59',NULL),
(2,2,'Ingenieria Ambiental',3,'1','2023-05-23 22:42:59',NULL),
(3,3,'Ingenieria Industrial',3,'1','2023-05-23 22:42:59',NULL);

/*Table structure for table `cursos` */

DROP TABLE IF EXISTS `cursos`;

CREATE TABLE `cursos` (
  `idcurso` int(11) NOT NULL AUTO_INCREMENT,
  `nombrecurso` varchar(100) NOT NULL,
  `creditos` int(11) NOT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  `idmatricula` int(11) DEFAULT NULL,
  PRIMARY KEY (`idcurso`),
  UNIQUE KEY `uk_nomcur_cursos` (`nombrecurso`),
  KEY `fk_idmatric_matricu` (`idmatricula`),
  CONSTRAINT `fk_idmatric_matricu` FOREIGN KEY (`idmatricula`) REFERENCES `alumnos_matriculas` (`idmatricula`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4;

/*Data for the table `cursos` */

insert  into `cursos`(`idcurso`,`nombrecurso`,`creditos`,`estado`,`create_at`,`update_at`,`idmatricula`) values 
(1,'Matemática',40,'1','2023-05-23 22:42:53',NULL,NULL),
(2,'Lenguaje',40,'1','2023-05-23 22:42:53',NULL,NULL),
(3,'Física',30,'1','2023-05-23 22:42:53',NULL,NULL),
(4,'Computación',25,'1','2023-05-23 22:42:53',NULL,NULL),
(5,'Inglés',30,'1','2023-05-23 22:42:53',NULL,NULL);

/*Table structure for table `docentes` */

DROP TABLE IF EXISTS `docentes`;

CREATE TABLE `docentes` (
  `iddocente` int(11) NOT NULL AUTO_INCREMENT,
  `docente` varchar(100) NOT NULL,
  `fechanac` date NOT NULL,
  `numdoc` varchar(11) NOT NULL,
  `especialidad` varchar(100) DEFAULT NULL,
  `idcurso` int(11) NOT NULL,
  `idcarrera` int(11) NOT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`iddocente`),
  UNIQUE KEY `uk_numdoc_doc` (`numdoc`),
  KEY `fk_idcur_curs` (`idcurso`),
  CONSTRAINT `fk_idcur_curs` FOREIGN KEY (`idcurso`) REFERENCES `cursos` (`idcurso`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

/*Data for the table `docentes` */

insert  into `docentes`(`iddocente`,`docente`,`fechanac`,`numdoc`,`especialidad`,`idcurso`,`idcarrera`,`estado`,`create_at`,`update_at`) values 
(1,'Mendoza Chia, Sergio','1985-03-08','21598674','',1,1,'1','2023-05-23 22:43:03',NULL),
(2,'Medrano Enriquez, Karina','1989-05-07','21598472','',2,2,'1','2023-05-23 22:43:03',NULL),
(3,'López Arteaga, Julio','1990-08-19','46389567','',3,3,'1','2023-05-23 22:43:03',NULL);

/*Table structure for table `usuarios` */

DROP TABLE IF EXISTS `usuarios`;

CREATE TABLE `usuarios` (
  `idusuario` int(11) NOT NULL AUTO_INCREMENT,
  `apellidos` varchar(50) NOT NULL,
  `nombres` varchar(50) NOT NULL,
  `fechanac` date NOT NULL,
  `nombreusuario` varchar(50) NOT NULL,
  `clave` varchar(90) NOT NULL,
  `telefono` char(9) DEFAULT NULL,
  `estado` char(1) NOT NULL DEFAULT '1',
  `create_at` datetime NOT NULL DEFAULT current_timestamp(),
  `update_at` datetime DEFAULT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE KEY `uk_nomusua_usu` (`nombreusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

/*Data for the table `usuarios` */

insert  into `usuarios`(`idusuario`,`apellidos`,`nombres`,`fechanac`,`nombreusuario`,`clave`,`telefono`,`estado`,`create_at`,`update_at`) values 
(1,'Rosales Magallanes','Luis Alberto','1990-02-15','rosalesmagallanes@senati.pe','123456','951357852','1','2023-05-23 22:42:04',NULL),
(2,'Rubio Pecho','Juana Rosa','1985-05-26','rubiopecho@senati.pe','123456','987456123','1','2023-05-23 22:42:04',NULL),
(3,'Poma Torres','Ruth Antonia','1992-08-25','pomatorres@senati.pe','123456','963842175','1','2023-05-23 22:42:04',NULL),
(4,'Yauca Saravia','Mario Raúl','1988-07-04','yaucasaravia@senati.pe','123456','913782647','1','2023-05-23 22:42:04',NULL);

/* Procedure structure for procedure `spu_listar_matricula` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_listar_matricula` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_listar_matricula`()
begin
select
	alumnos_matriculas.`idmatricula`,
	alumnos_matriculas.`alumno`,
	docentes.`docente`,
	carreras.`nombrecarrera`,
	alumnos_matriculas.`periodo`,
	alumnos_matriculas.`semestre`,
	alumnos_matriculas.`fechainicio`,
	alumnos_matriculas.`fechafinal`,
	alumnos_matriculas.`pago`
from alumnos_matriculas
	inner join docentes on docentes.`iddocente` = alumnos_matriculas.`iddocente`
	inner join carreras on carreras.`idcarrera` = alumnos_matriculas.`idcarrera`;
-- WHERE idmatricula = _idmatricula;
end */$$
DELIMITER ;

/* Procedure structure for procedure `spu_registrar_matricula` */

/*!50003 DROP PROCEDURE IF EXISTS  `spu_registrar_matricula` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `spu_registrar_matricula`(
	in _matriculado varchar(100),
	in _fechanac	date,
	in _numdoc	varchar(11),
	in _iddocente	int,
	in _idcarrera	int,
	in _periodo	varchar(10),
	in _semestre	varchar(10),
	in _fechainicio date,
	in _fechafinal 	date,
	in _pago	decimal(7,2)
)
begin
insert into alumnos_matriculas (alumno,fechanac,numdoc,iddocente,idcarrera,periodo,semestre,fechainicio,fechafinal,pago) values
	(_matriculado,_fechanac,_numdoc,_iddocente,_idcarrera,_periodo,_semestre,_fechainicio,_fechafinal,_pago);
end */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
